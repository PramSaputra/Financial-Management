//
//  ExpensesAddView.swift
//  Financial Management
//
//  Created by Pramudya Prameswara Trisna Saputra on 19/10/22.
//

import SwiftUI

struct ExpensesAddView: View {
    @StateObject var expenses1: ExpensesSaveViewModel
    @ObservedObject var yourOutcome: incomeModel
    @State var name = ""
    @State var type = "Food/Drinks"
    @State var amount : Int? = nil
    @State var alert = false
    @Environment(\.dismiss) var dismiss
    
    let totalExpenses: Int
    
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
                TextField("Input Your Expenses Amount Here", value: $amount, format: .currency(code:Locale.current.currencyCode ?? "id_ID"))
                    .keyboardType(.numberPad)
            }.navigationTitle("Add New Expenses")
                .navigationBarItems(leading:                     Button("Back"){
                    dismiss()
                }, trailing: Button("Save"){
                    if amount ?? 0 == 0 || amount == nil{
                        yourOutcome.zeroValue.toggle()
                    }else if amount ?? 0 <= 0{
                        alert.toggle()
                    } else {
                        let item = ExpensesItemModel(name: name, whatFor: type, expense: amount ?? 0)
                        expenses1.items.append(item)
                        print("2")
                        dismiss()
                    }
                })
            .alert(isPresented: $yourOutcome.zeroValue) {
                Alert(title: Text("Failed To Save"), message: Text("Your Expenses Amount Are Empty"), dismissButton: .default(Text("Close")))
        }
        }
        .alert(isPresented: $alert) {
            Alert(title: Text("Failed To Save"), message: Text("You Can't Input a Minus Expenses Inside Your Expenses!"), dismissButton: .default(Text("Close")))
    }
    }
}

struct ExpensesAddView_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesAddView(expenses1: ExpensesSaveViewModel(), yourOutcome: incomeModel(), totalExpenses: 10)
    }
}
