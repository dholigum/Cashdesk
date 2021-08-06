//
//  ExpenseSheet.swift
//  Cashdeck
//
//  Created by Syahrul Apple Developer BINUS on 06/08/21.
//

import SwiftUI

struct ExpenseSheet: View {
    
    @ObservedObject var expenseVM = ExpenseViewModel()
    
    let categories = ["Utilities", "Transport", "Housing", "Personal", "Finance"]
    let repeats = ["Every Week", "Every Month", "Every 2 Month", "Every 4 Month", "Every 6 Month"]
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Button(action: {
                    expenseVM.isNewData = false
                    NSApp.mainWindow?.endSheet(NSApp.keyWindow!)
                }, label: {
                    Text("Cancel")
                        .font(Font.custom("SFProDisplay-Semibold", size: 16))
                })
                .buttonStyle(PlainButtonStyle())
                .padding(.horizontal)
                
                Spacer()
                
                Text("Add Expense")
                    .foregroundColor(Color("OrangeColor"))
                    .font(Font.custom("SFProDisplay-Semibold", size: 18))
                
                Spacer()
                
                Text("\t\t")
                    .padding(.horizontal)
                
                //                Button(action: {
                //                    self.isVisible = false
                //                }, label: {
                //                    Text("   Save")
                //                        .font(Font.title3.weight(.medium))
                //                })
                //                .buttonStyle(PlainButtonStyle())
                //                .padding(.horizontal)
                
            } // Sheet Header
            .frame(width: 392, height: 50)
            .background(Color("AccentColor"))
            
            VStack(spacing: 8) {
                TextField("...", text: $expenseVM.amount)
                    .textFieldStyle(PlainTextFieldStyle())
                    .font(Font.custom("SFProDisplay-Semibold", size: 28))
                    .foregroundColor(Color("OrangeColor"))
                    .modifier(WithTopLabelTextField(labelName: "Amount"))
                    .padding(.top)
                
                TextField("Expense Name", text: $expenseVM.name)
                    .textFieldStyle(PlainTextFieldStyle())
                    .font(Font.custom("SFProDisplay-Semibold", size: 24).weight(.light))
                    .modifier(WithTopLabelTextField(labelName: "Name"))
                
                TextField("Expense Quantity", text: $expenseVM.quantity)
                    .textFieldStyle(PlainTextFieldStyle())
                    .font(Font.custom("SFProDisplay-Semibold", size: 24).weight(.light))
                    .modifier(WithTopLabelTextField(labelName: "Quantity"))
                
                Picker("", selection: $expenseVM.categoryIndex) {
                    ForEach(0 ..< categories.count) {
                        Text(self.categories[$0])
                            .font(Font.custom("SFProDisplay-Semibold", size: 16).weight(.light))
                    }
                }
                .pickerStyle(PopUpButtonPickerStyle())
                .modifier(WithTopLabelTextField(labelName: "Category"))
                
                DatePicker("", selection: $expenseVM.date, displayedComponents: .date)
                    .pickerStyle(InlinePickerStyle())
                    .font(Font.custom("SFProDisplay-Semibold", size: 24).weight(.light))
                    .modifier(WithTopLabelTextField(labelName: "Date"))
                
                Picker("", selection: $expenseVM.repeatIndex) {
                    ForEach(0 ..< repeats.count) {
                        Text(self.repeats[$0])
                            .font(Font.custom("SFProDisplay-Semibold", size: 16).weight(.light))
                    }
                }
                .pickerStyle(PopUpButtonPickerStyle())
                .modifier(WithTopLabelTextField(labelName: "Repeat"))
            }
            
            Spacer()
            
            Button(action: {
                expenseVM.writeExpense()
                expenseVM.isNewData = false
                NSApp.mainWindow?.endSheet(NSApp.keyWindow!)
                
            }, label: {
                Text("Save Expense")
                    .foregroundColor(Color("AccentColor2"))
                    .font(Font.custom("SFProDisplay-Semibold", size: 16))
                    .frame(width: 358, height: 50)
                    .background(Color("AccentColor"))
                    .clipped()
                    .cornerRadius(16)
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 4, x: 2, y: 2)
                    .padding(.bottom)
            })
            .buttonStyle(PlainButtonStyle())
        }
        .frame(width: 392, height: 685)
        .background(Color("MainColor"))
    }
}

struct ExpenseSheet_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseSheet()
    }
}
