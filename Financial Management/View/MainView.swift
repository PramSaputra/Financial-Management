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
    @State var startingGauge : Double = 0.5
    @Environment(\.dismiss) var dismiss
    
    let currentIncome : Int
    let limitIncome : Int
    
    var resultExpenses = 0
    
    var trueGauge : Double{
        let total = totalExpenses
        let limit = sisaUang.limitExpenses ?? 0
        let gauge = Double(total) / Double(limit)
        
        return Double(gauge)
        //        if total == 0 || limit == 0{
        //            return 0
        //        } else{
        //        }
    }
    
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
            ZStack {
                ScrollView {
                    ZStack{
                        VStack{
                            ZStack{
                                VStack{
                                    HStack{
                                        Text("Your Current Money")
                                            .foregroundColor(.white)
                                            .padding()
                                            .font(Font.title3.bold())
                                            .frame(height: 10)
                                        Spacer()
                                        Button("Edit", action: {
                                            updateAlert.toggle()
                                        }).font(Font.body.bold())
                                            .padding()
                                            .background(Color("Secondary"))
                                            .foregroundColor(.white)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(.gray))
                                            .cornerRadius(10)
                                        Spacer()
                                            .frame(width: 15)
                                    }
                                    HStack{
                                            Text("Rp \(uangSisa)")
                                                .font(Font.largeTitle.bold())
                                                .padding()
                                                .foregroundColor(.white)
                                                .cornerRadius(10)
                                                .lineLimit(2)
//                                            Spacer()
                                        if uangSisa >= 0 || uangSisa == 0{
                                            Text("Left")
                                                .font(Font.body.bold())
                                                .padding()
//                                                .frame(width: 50,height: 35)
//                                                .background(Color("Primary"))
                                                .foregroundColor(.white)
//                                                .overlay(
//                                                    RoundedRectangle(cornerRadius: 10)
//                                                        .stroke(.gray)
//                                                )
                                                .cornerRadius(10)
                                            
                                        Spacer()
                                            Spacer()
                                                .frame(width: 15)
                                        } else {
                                            Text("Over Spent")
                                                .font(Font.body.bold())
                                                .padding()
//                                                .background(Color("Red"))
                                                .foregroundColor(.white)
//                                                .overlay(
//                                                    RoundedRectangle(cornerRadius: 10)
//                                                        .stroke(.gray))
                                                .cornerRadius(10)
                                            Spacer()
                                        }
                                           
                                        
                                    }
                                    
                                    HStack{
                                        if trueGauge >= 1 {
                                            Gauge(value: trueGauge) {
                                            }
                                            .background(Color("Secondary"))
                                            .cornerRadius(20)
                                            .padding()
                                            .frame(width: 400, height: 10)
                                            .tint(Color("Red"))
                                        }else{
                                            Gauge(value: trueGauge) {
                                            }
                                            .background(Color("Secondary"))
                                            .cornerRadius(20)
                                            .padding()
                                            .frame(width: 400, height: 10)
                                            .tint(Color("Fourth"))
                                        }
                                        
                                    }
                                    HStack{
                                        Text("Rp \(totalExpenses) of Rp \(limitIncome) spent")
                                            .font(.body)
                                            .padding()
                                            .foregroundColor(.white)
                                            .cornerRadius(10)
                                        Spacer()
                                    }
                                    Spacer()
                                        .frame(height: 30)
                                }
                            }.background(Color("Primary"))
                            HStack{
                                Text("Latest Expenses")
                                    .font(Font.title.bold())
                                    .padding()
                                    .cornerRadius(10)
                                Spacer()
                                Button(action: {
                                    self.showingAddExpense.toggle()
                                },label:{
                                    Image(systemName: "plus.circle")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 30)
                                        .foregroundColor(Color("Fifth"))
                                        .padding()
                                }).sheet(isPresented: $updateAlert, onDismiss: {
                                    if sisaUang.updateLimit == true{
                                        self.showingAdditionalLimit.toggle()
                                        self.sisaUang.updateLimit.toggle()
                                    }; if sisaUang.updateMonthly == true{
                                        self.showingAdditionalIncome.toggle()
                                        self.sisaUang.updateMonthly.toggle()
                                    }; if sisaUang.addExpenses == true{
                                        self.showingAddExpense.toggle()
                                        self.sisaUang.addExpenses.toggle()
                                    }
                                }){
                                    MainViewSheet(yourOutcome: sisaUang)
                                        .navigationAppearance(backgroundColor: .systemBackground, foregroundColor: UIColor.init(Color("Reversed")), tintColor: nil, hideSeparator: true, hideNavbarBackground: false)
                                        .accentColor(Color("Fifth"))
                                        .presentationDetents([.fraction(0.25)])
                                }
                                .sheet(isPresented: $showingAdditionalLimit){
                                    AdditionalLimitView(income: sisaUang, currentMonthlyIncome: monthlySisa)
                                        .accentColor(Color("Fifth"))
                                        .navigationAppearance(backgroundColor: .systemBackground, foregroundColor: UIColor.init(Color("Reversed")), tintColor: nil, hideSeparator: true, hideNavbarBackground: false)
                                }
                                .sheet(isPresented: $showingAdditionalIncome){
                                    AdditionalIncomeView(income: sisaUang)
                                        .accentColor(Color("Fifth"))
                                        .navigationAppearance(backgroundColor: .systemBackground, foregroundColor: UIColor.init(Color("Reversed")), tintColor: nil, hideSeparator: true, hideNavbarBackground: false)
                                }
                                .sheet(isPresented: $showingAddExpense, onDismiss: {
                                    if uangSisa <= 0{
                                        self.limitAlert.toggle()
                                    }
                                }){
                                    ExpensesAddView(expenses1: expenses, yourOutcome: sisaUang, totalExpenses: totalExpenses)
                                        .accentColor(Color("Fifth"))
                                        .navigationAppearance(backgroundColor: .systemBackground, foregroundColor: UIColor.init(Color("Reversed")), tintColor: nil, hideSeparator: true, hideNavbarBackground: false)
                                    
                                }
                            }
                            VStack{                                ForEach(expenses.items.reversed().prefix(5)) {
                                item in
                                HStack{
                                    if item.name == "" {
                                        VStack(alignment: .leading){
                                            Text(item.whatFor)
                                            Text("\(item.date.formatted(date: .complete, time: .shortened))")
                                                .foregroundColor(.secondary)
                                                .font(.footnote)
                                        }
                                        Spacer()
                                        VStack{
                                            Text("Rp \(item.expense)")
                                            Spacer()
                                        }
                                    } else {
                                        VStack(alignment: .leading){
                                            Text(item.name)
                                                .lineLimit(2)
                                            Text(item.whatFor)
                                                .font(.footnote)
                                                .foregroundColor(.secondary)
                                                .lineLimit(2)
                                            Text("\(item.date.formatted(date: .complete, time: .shortened))")
                                                .foregroundColor(.secondary)
                                                .font(.footnote)
                                                .lineLimit(2)
                                        }
                                        Spacer()
                                        VStack{
                                            Text("Rp \(item.expense)")
                                                .lineLimit(2)
                                            Spacer()
                                        }
                                        
                                    }
                                }
                                .padding()
                                Divider()
                                    .background(.gray)
                            }
                                NavigationLink(destination: ExpensesHistoryView(expenses: expenses)) {
                                    Text("See More")
                                        .padding()
                                        .frame(width: 380)
                                        .foregroundColor(Color("Fifth"))
                                        .font(.body)
                                    
                                }
                                
                            }
                            Spacer()
                        }
                        
                        Spacer()
                    }.navigationBarTitle(Text("Dashboard"))
                    
                    //                    }
                }
                .alert(isPresented: $limitAlert) {
                    Alert(title: Text("Over Spent"), message: Text("It Seems You Have Been Over Spent Your Current Limit Budget"), dismissButton: .default(Text("Close")))
                }
            }
        }
        .accentColor(.white)
        .navigationAppearance(backgroundColor: UIColor.init(Color("Primary")), foregroundColor: .white, hideSeparator: true)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(sisaUang: incomeModel(), currentIncome: 2000000, limitIncome: 160000000)
    }
}
