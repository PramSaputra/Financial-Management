//
//  DummyView.swift
//  Financial Management
//
//  Created by Pramudya Prameswara Trisna Saputra on 10/10/22.
//

import SwiftUI

struct MainView: View {
    //    @AppStorage("Za Warudo") var onboarding = true
    @ObservedObject var sisaUang : incomeModel
    @StateObject var expenses = ExpensesSaveViewModel()
    @State var updateAlert = false
    @State var showingAdditionalIncome = false
    @State var showingAddExpense = false
    @State var showingAdditionalLimit = false
    @State var limitAlert = false
    @Environment(\.dismiss) var dismiss
    
    
    
    let currentIncome : Int
    let limitIncome : Int
    
    
    
    var resultExpenses = 0
    
    var monthlySisa: Int{
        let monthlyIncome = sisaUang.monthlyIncome
        let outcome = totalExpenses
        let currentBudget = (monthlyIncome ?? 0) - outcome
        
        return currentBudget
    }
    
    var uangSisa: Int{
        let moneyLimit = limitIncome
        let outcome = totalExpenses
        let currentBudget = moneyLimit - outcome
        
        return currentBudget
    }
    
    var totalExpenses: Int{
        let items = expenses.items
        
        var expensesValue = 0
        
        items.forEach { value in
            //value ini merupakan var dari forEach
            expensesValue += value.expense
        }
        
        return expensesValue
    }
    
    
    var body: some View {
        NavigationView{
            ScrollView {
                ZStack{
                    HStack{
                        VStack{
                            HStack{
                                Text("Your Current Budget")
                                    .font(.title3)
                                    .padding()
                                Spacer()
                                Button(action: {
                                    updateAlert.toggle()
                                },label:{
                                    Image(systemName: "plus.circle")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 30)
                                        .padding()
                                }).alert("Choose What To Update", isPresented: $updateAlert) {
                                    
                                    Button("Update Monthly Income") {
                                        showingAdditionalIncome.toggle()
                                        dismiss()
                                    }
                                    Button("Update Limit Expenses") {
                                        showingAdditionalLimit.toggle()
                                        dismiss()
                                    }
                                    Button("Cancel") {
                                        dismiss()
                                    }
                                }
                                .sheet(isPresented: $showingAdditionalLimit){
                                    AdditionalLimitView(income: sisaUang, currentMonthlyIncome: monthlySisa)
                                }
                                .sheet(isPresented: $showingAdditionalIncome){
                                    AdditionalIncomeView(income: sisaUang)
                                }
                                
                            }
                            HStack{
                                Text("Rp \(uangSisa)")
                                    .font(.title)
                                    .padding()
                                    .background(.gray)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .padding()
                                    .frame(height: 50)
                                Spacer()
                            }
                            HStack{
                                Text("Your Expenses/Expenses Limit")
                                    .font(.title3)
                                    .padding()
                                    .cornerRadius(10)
                                Spacer()
                            }
                            HStack{
                                Text("Rp \(totalExpenses)/Rp \(limitIncome)")
                                    .font(.title3)
                                    .padding()
                                    .background(.gray)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .padding()
                                    .frame(height: 50)
                                Spacer()
                            }
                            HStack{
                                Text("Input Your Expenses here")
                                    .font(.title3)
                                    .padding()
                                    .cornerRadius(20)
                                Spacer()
                                Button {showingAddExpense = true
                                }label:{
                                    Image(systemName: "plus.circle")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 30)
                                        .padding()
                                }.sheet(isPresented: $showingAddExpense, onDismiss: {
                                    if uangSisa <= 0{
                                        self.limitAlert.toggle()
                                    }
                                }) {
                                    ExpensesAddView(expenses1: expenses, yourOutcome: sisaUang, totalExpenses: totalExpenses)
                                }
                            }
                            HStack{
                                Text("Recent Expenses")
                                    .font(.title)
                                    .padding()
                                    .cornerRadius(10)
                                Spacer()
                                NavigationLink(("See More"), destination: ExpensesHistoryView(expenses: expenses))
                                    .padding()
                                    .font(.title2)
                            }
                            VStack{                                ForEach(expenses.items.reversed().prefix(5)) {
                                item in
                                HStack{
                                    VStack(alignment: .leading){
                                        Text(item.name)
                                        Text(item.whatFor)
                                    }
                                    Spacer()
                                    Text("Rp \(item.expense)")
                                }.padding()
                                    .background(.bar)
                                    .cornerRadius(20)
                                Divider()
                            }
                            }
                            Spacer()
                        }
                        Spacer()
                    }.navigationTitle("Home")
                }
            }
            .alert(isPresented: $limitAlert) {
                Alert(title: Text("Over Limit"), message: Text("It Seems You Have Been Spending Over Your Current Budget"), dismissButton: .default(Text("Close")))
            }
        }.navigationBarHidden(true)
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(sisaUang: incomeModel(), currentIncome: 2000000, limitIncome: 1600000)
    }
}
