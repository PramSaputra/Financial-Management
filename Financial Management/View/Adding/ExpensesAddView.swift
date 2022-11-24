//
//  ExpensesAddView.swift
//  Financial Management
//
//  Created by Pramudya Prameswara Trisna Saputra on 19/10/22.
//

import SwiftUI

struct ExpensesAddView: View {
    @ObservedObject var expenses1: ExpensesSaveViewModel
    @ObservedObject var yourOutcome: incomeModel
    @State var name = ""
    @State var type = "Food/Drinks"
    @State var amount : Int? = nil
    @State var alert = false
//    @State var image : UIImage = [""]
    @Environment(\.dismiss) var dismiss
    
    let totalExpenses: Int
    
    let types = ["Food/Drinks", "Others"]
    
    
    
//    init (expenses1:ExpensesSaveViewModel, yourOutcome: incomeModel, totalExpenses:Int){
//        UINavigationBar().largeTitleTextAttributes = [.foregroundColor: UIColor.init(Color.black)]
//        self.expenses1 = expenses1
//        self.yourOutcome = yourOutcome
//        self.totalExpenses = totalExpenses
//
//    }
    
  
    var body: some View {
        NavigationView{
            Form{
                Section{
                    
                }
                TextField("Input Your Expenses Amount Here", value: $amount, format: .currency(code:Locale.current.currency?.identifier ?? "id_ID"))
                    .keyboardType(.numberPad)
                Picker("Category", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                Section{
                    TextField("Add Additional Information Here", text: $name)
                }
            }
            .navigationTitle("Add New Expenses")
            
                .navigationBarItems(leading: Button("Back"){
                    dismiss()
                }, trailing: Button("Save"){
                    if amount ?? 0 == 0 || amount == nil{
                        yourOutcome.zeroValue.toggle()
                    }else if amount ?? 0 <= 0{
                        alert.toggle()
                    } else {
                        let item = ExpensesItemModel(name: name, whatFor: type, expense: amount ?? 0, date: Date())
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
        ExpensesAddView(expenses1: ExpensesSaveViewModel(), yourOutcome: incomeModel(), totalExpenses: 0)
    }
}
