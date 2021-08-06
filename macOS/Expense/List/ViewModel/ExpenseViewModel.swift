//
//  ExpenseViewModel.swift
//  Cashdeck
//
//  Created by Syahrul Apple Developer BINUS on 06/08/21.
//

import SwiftUI

class ExpenseViewModel: ObservableObject {
    
    @Published var expenses: [Expense] = []
    
    @Published var amount: String = ""
    @Published var name: String = ""
    @Published var quantity: String = ""
    @Published var categoryIndex = 0
    @Published var date = Date()
    @Published var repeatIndex = 0
        
    @Published var isNewData = false
    @Published var updateItem: Expense!
    
    let categories = ["Utilities", "Transport", "Housing", "Personal", "Finance"]
    let repeats = ["Every Week", "Every Month", "Every 2 Month", "Every 4 Month", "Every 6 Month"]
    
    let context = CoreDataManager.sharedManager.persistentContainer.viewContext
    
    func writeExpense() {
        
        if updateItem != nil {
            // Update old data ...
            updateItem.date = date
            updateItem.category = categories[categoryIndex]
            updateItem.name = name
            updateItem.price = Int64(amount) ?? 0
            updateItem.quantity = Int64(quantity) ?? 0
            updateItem.repeatEvery = repeats[repeatIndex]
            
            CoreDataManager.sharedManager.saveContext()
            
            // Removing updatingItem if successfull
            updateItem = nil
            isNewData.toggle()
            resetExpenseData()
            
            return
        }
        
        let newExpense = Expense(context: context)
        
        newExpense.date = date
        newExpense.name = name
        newExpense.category = categories[categoryIndex]
        newExpense.quantity = Int64(quantity) ?? 0
        newExpense.price = Int64(amount) ?? 0
        newExpense.repeatEvery = repeats[repeatIndex]
        expenses.append(newExpense)
        
        // Saving data ...
        do {
            CoreDataManager.sharedManager.saveContext()
            
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
        categoryIndex = categories.firstIndex(of: expense.category!)!
        repeatIndex = repeats.firstIndex(of: expense.repeatEvery!)!
        isNewData.toggle()
    }
    
    func getAllExpense() {
        let fetchRequest: NSFetchRequest<Expense> = Expense.fetchRequest()
        
        do {
            expenses = try context.fetch(fetchRequest)

        } catch let error as NSError {
            print("\(error)")
        }
    }
    
    func deleteExpense(_ expense: Expense) {
        
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