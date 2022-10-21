//
//  ExpensesAddView.swift
//  Financial Management
//
//  Created by Pramudya Prameswara Trisna Saputra on 19/10/22.
//

import SwiftUI

struct ExpensesAddView: View {
    @StateObject var expenses1: ExpensesSaveViewModel
    @StateObject var yourOutcome: incomeViewModel
    @State var name = ""
    @State var type = "Food/Drinks"
    @State var amount : Int? = nil
    @Environment(\.dismiss) var dismiss
    
    let types = ["Food/Drinks", "Others"]
    
    var body: some View {
        NavigationView{
//            ZStack{
//                VStack{
//                    Text("Input Your Expenses Here")
//                    TextField("Your Expenses", text: $name)
//                        .padding()
//                }
//            }
            Form{
                TextField("Input Your Expenses Here", text: $name)
                Picker("Category", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("0", value: $amount, format: .currency(code:Locale.current.currencyCode ?? "id_ID"))
                    .keyboardType(.numberPad)
            }.navigationTitle("Add New Expenses")
                .navigationBarItems(leading:                     Button("Back"){
                    dismiss()
                }, trailing: Button("Save"){
                    let item = ExpensesItemViewModel(name: name, whatFor: type, expense: amount ?? 0)
                    expenses1.items.append(item)
                    dismiss()
                })
        }
    }
}

struct ExpensesAddView_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesAddView(expenses1: ExpensesSaveViewModel(), yourOutcome: incomeViewModel())
    }
}
