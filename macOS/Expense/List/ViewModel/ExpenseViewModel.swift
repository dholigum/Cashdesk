//
//  ExpenseViewModel.swift
//  Cashdeck
//
//  Created by Syahrul Apple Developer BINUS on 06/08/21.
//

import SwiftUI

class ExpenseViewModel: ObservableObject {
    
    @Published var expenses: [Expense] = []
    @Published var totalExpense: Int = 0
    @Published var groupedExpense: [SimpleExpense] = []
    
    @Published var amount: String = "" {
        didSet {
            let filtered = amount.filter { "0123456789".contains($0) }
            if filtered != amount { self.amount = filtered } }
        }
    
    @Published var quantity: String = "" {
        didSet {
            let filtered = quantity.filter { "0123456789".contains($0) }
            if filtered != quantity { self.quantity = filtered } }
        }
    
    @Published var name: String = ""
    @Published var categoryIndex = 0
    @Published var date = Date()
    @Published var repeatIndex = 0
    
    @Published var isNewData = false
    @Published var updateItem: Expense!
    
    var simpleExpenses: [SimpleExpense] = []
    
    let context = CoreDataManager.sharedManager.persistentContainer.viewContext
    
    func writeExpense() {
        
        if updateItem != nil {
            // Update old data ...
            updateItem.date = date
            updateItem.category = K().categories[categoryIndex]
            updateItem.name = name
            updateItem.price = Int64(amount) ?? 0
            updateItem.quantity = Int64(quantity) ?? 0
            updateItem.repeatEvery = K().repeats[repeatIndex]
            
            CoreDataManager.sharedManager.saveContext()
            totalExpense += Int(amount) ?? 0
            
            // Removing updatingItem if successfull
            updateItem = nil
            isNewData.toggle()
            resetExpenseData()
            
            return
        }
        
        let newExpense = Expense(context: context)
        
        newExpense.date = date
        newExpense.name = name
        newExpense.category = K().categories[categoryIndex]
        newExpense.quantity = Int64(quantity) ?? 0
        newExpense.price = Int64(amount) ?? 0
        newExpense.repeatEvery = K().repeats[repeatIndex]
        
        // Saving data ...
        do {
            CoreDataManager.sharedManager.saveContext()
            expenses.append(newExpense)
            totalExpense += Int(amount) ?? 0
            
            // Closing view when success
            isNewData.toggle()
            resetExpenseData()
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func editExpense(_ expense: Expense) {
        updateItem = expense
        
        // Togging the newDataView ...
        date = expense.date!
        amount = String(expense.price)
        name = expense.name!
        quantity = String(expense.quantity)
        categoryIndex = K().categories.firstIndex(of: expense.category!)!
        repeatIndex = K().repeats.firstIndex(of: expense.repeatEvery!)!
        isNewData.toggle()
    }
    
    func getAllExpense() {
        let fetchRequest: NSFetchRequest<Expense> = Expense.fetchRequest()
        
        do {
            expenses = try context.fetch(fetchRequest)
            totalExpense = Int(expenses.reduce(0) { $0 + $1.price })
            
            for expense in expenses {
                let newSimpleExpense = SimpleExpense(name: expense.category ?? "", cost: Double(expense.price ?? 0))

                simpleExpenses.append(newSimpleExpense)
            }
            
            groupedExpense = simpleExpenses.grouped()
            
        } catch let error as NSError {
            print("\(error)")
        }
    }
    
    func deleteExpense(_ expense: Expense) {
        
        totalExpense -= Int(expense.price)
        CoreDataManager.sharedManager.deleteContext(expense)
        
        if let index = expenses.firstIndex(of: expense) {
            expenses.remove(at: index)
        }
    }
    
    func resetExpenseData() {
        amount = ""
        name = ""
        quantity = ""
        categoryIndex = 0
        repeatIndex = 0
        date = Date()
    }
}
