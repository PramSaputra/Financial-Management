//
//  DummyView.swift
//  Financial Management
//
//  Created by Pramudya Prameswara Trisna Saputra on 10/10/22.
//

import SwiftUI

struct MainView: View {
    @AppStorage("Za Warudo") var onboarding = true
    
    @StateObject var sisaUang = incomeViewModel()
    @StateObject var pengeluaran = ExpensesSaveViewModel()
    
    @State var showingAddExpense = false
    
    let currentIncome : Int
    let limitIncome : Int
    
    var resultExpenses = 0
    
    var uangSisa: Int{
        let moneyLimit = limitIncome 
        let outcome = totalExpenses
        let currentBudget = moneyLimit - outcome
        
        return currentBudget
    }
    
    var totalExpenses: Int{
        let items = pengeluaran.items
        
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
                HStack{
                    VStack{
                        HStack{
                            Text("Your Current Budget")
                                .font(.title3)
                                .padding()
                            Spacer()
                            Button(action: {
                                print("ok")
                            }, label:{
                                Image(systemName: "plus.circle")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 30)
                            })
                            
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
                            }.sheet(isPresented: $showingAddExpense){
                                ExpensesAddView(expenses1: pengeluaran, yourOutcome: incomeViewModel())
                            }
                        }
                        HStack{
                            Text("Recent Expenses")
                                .font(.title)
                                .padding()
                                .cornerRadius(10)
                            Spacer()
                            NavigationLink(("See More"), destination: ExpensesHistoryView())
                            .padding()
                            .font(.title2)
                        }
                        VStack{                                ForEach(pengeluaran.items.prefix(5)) {
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
        }.navigationBarHidden(true)
//            .fullScreenCover(isPresented: $onboarding, content: {
//                DashboardStartUpView(onboarding: $onboarding)
//            })
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(currentIncome: 2000000, limitIncome: 1600000)
    }
}
