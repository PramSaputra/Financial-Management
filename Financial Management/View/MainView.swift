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
                //                GeometryReader { reader in
                //                    Color("Primary")
                //                        .frame(height: reader.safeAreaInsets.top, alignment: .top)
                //                        .ignoresSafeArea()
                //                }
                ScrollView {
//                    ZStack{
                        ZStack{
                            VStack{
                                ZStack{
                                    VStack{
                                        HStack{
//                                            Spacer()
//                                                .frame(width: 5)
                                            Text("Your Current Money")
                                                .padding()
                                                .font(Font.title3.bold())
                                                .frame(height: 20)
                                            Spacer()
                                        }
                                        if uangSisa >= 999999999 || uangSisa <= -999999{
                                            if uangSisa >= 0 {
                                                HStack{
                                                    Text("Left")
                                                        .font(Font.body.bold())
                                                        .padding()
                                                        .frame(height: 35)
                                                        .background(Color("Secondary"))
                                                        .foregroundColor(.white)
                                                        .overlay(
                                                        RoundedRectangle(cornerRadius: 10)
                                                            .stroke(.gray))
                                                        .cornerRadius(10)
                                                    Spacer()
                                                        .frame(width: 30)
                                                }
                                            } else {
                                                HStack{
                                                    Spacer()
                                                    Text("Over Spent")
                                                        .font(Font.body.bold())
                                                        .padding()
                                                        .frame(height: 35)
                                                        .background(Color("Red"))
                                                        .foregroundColor(.white)
                                                        .overlay(
                                                        RoundedRectangle(cornerRadius: 10)
                                                            .stroke(.gray))
                                                        .cornerRadius(10)
                                                    Spacer()
                                                        .frame(width: 30)
                                                }
                                            }
                                        }
                                        
                                        
                                        HStack{
                                            Text("Rp \(uangSisa)")
                                                .font(Font.largeTitle.bold())
                                                .padding()
                                                .foregroundColor(.white)
                                                .cornerRadius(10)
//                                                .padding()
                                                .frame(height: 50)
                                            if uangSisa >= 999999999 || uangSisa <= -999999 {
                                            } else{
                                                if uangSisa >= 1 {
                                                    Text("Left")
                                                        .font(Font.body.bold())
                                                        .padding()
                                                        .frame(height: 35)
                                                        .background(Color("Secondary"))
                                                        .foregroundColor(.white)
                                                        .overlay(
                                                            RoundedRectangle(cornerRadius: 10)
                                                                .stroke(.gray))
                                                        .cornerRadius(10)
                                                }else {
                                                        Text("Over Spent")
                                                        .font(Font.body.bold())
                                                        .padding()
                                                        .frame(height: 35)
                                                        .background(Color("Red"))
                                                        .foregroundColor(.white)
                                                        .overlay(
                                                            RoundedRectangle(cornerRadius: 10)
                                                                .stroke(.gray))
                                                        .cornerRadius(10)
                                                }
                                            }
                                            Spacer()
                                        }
                                        
                                        HStack{
                                            if trueGauge >= 1 {
                                                Gauge(value: trueGauge) {
                                                }
    //                                            .scaleEffect(2)
    //                                            .frame(height: 50)
                                                .background(Color("Secondary"))
                                                    .cornerRadius(20)
                                                .padding()
                                                .frame(width: 400, height: 10)
    //                                            .padding()
                                                .tint(Color("Red"))
                                            }else{
                                                Gauge(value: trueGauge) {
                                                }
    //                                            .scaleEffect(2)
    //                                            .frame(height: 50)
                                                .background(Color("Secondary"))
                                                    .cornerRadius(20)
                                                .padding()
                                                .frame(width: 400, height: 10)
    //                                            .padding()
                                                .tint(Color("Fourth"))
                                            }
                                            
                                        }
                                        HStack{
                                            Text("Rp \(totalExpenses) of Rp \(limitIncome) spent")
                                                .font(.body)
                                                .padding()
                                                .foregroundColor(.white)
                                                .cornerRadius(10)
//                                                .padding()
                                            Spacer()
                                        }
                                        Spacer()
                                            .frame(height: 30)
                                    }
                                }.background(Color("Primary"))
//                                HStack{
//                                    Text("Input Your Expenses here")
//                                        .font(.title3)
//                                        .padding()
//                                        .cornerRadius(20)
//                                    Spacer()
//                                    Button {showingAddExpense = true
//                                    }label:{
//                                        Image(systemName: "plus.circle")
//                                            .resizable()
//                                            .scaledToFit()
//                                            .frame(height: 30)
//                                            .padding()
//                                            .foregroundColor(Color("Fifth"))
//                                    }
//                                }
                                HStack{
                                    Text("Latest Expenses")
                                        .font(Font.title.bold())
                                        .padding()
//                                        .foregroundColor(Color("Primary"))
                                        .cornerRadius(10)
                                    Spacer()
                                    
                                    //                                        .navigationAppearance(backgroundColor: .white, foregroundColor: .black, tintColor: .white, hideSeparator: false, hideNavbarBackground: true)
                                }
                                VStack{                                ForEach(expenses.items.reversed().prefix(5)) {
                                    item in
                                    HStack{
                                        if item.name == "" {
                                            VStack(alignment: .leading){
//                                                Text(item.name)
                                                Text(item.whatFor)
//                                                    .font(.callout)
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
//                                                    .lineLimit(nil)
                                                Text(item.whatFor)
                                                    .font(.footnote)
                                                    .foregroundColor(.secondary)
                                                Text("\(item.date.formatted(date: .complete, time: .shortened))")
                                                    .foregroundColor(.secondary)
                                                    .font(.footnote)
//                                                    .lineLimit(10)
                                            }
                                            Spacer()
                                            VStack{
                                                Text("Rp \(item.expense)")
                                                Spacer()
                                            }
                                            
                                        }
                                    }
                                    .padding()
//                                        .background(.quaternary)
//                                        .cornerRadius(10)
//                                        .padding()
//                                        .frame(height: 80)
                                    
                                    
                                    Divider()
                                        .background(.gray)
                                }
                                    NavigationLink(destination: ExpensesHistoryView(expenses: expenses)) {
                                        Text("See More")
                                            .padding()
                                            .frame(width: 380)
                                                .foregroundColor(Color("Fifth"))
                                            .background(.quaternary)
                                            .font(.body)

                                    }
                                    
                                }
                                Spacer()
                            }
                            
                            Spacer()
                        }.navigationBarTitle(Text("Dashboard"))
                            .navigationBarItems(trailing:
                                                    Button(action: {
                                updateAlert.toggle()
                            },label:{
                                Image(systemName: "plus.circle")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 30)
                                    .foregroundColor(.white)
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
                                    .presentationDetents([.fraction(0.4)])
                            }
//                                                        .alert("Choose What To Update", isPresented: $updateAlert) {
//
//                                Button("Update Monthly Income") {
//                                    showingAdditionalIncome.toggle()
//                                    dismiss()
//                                }
//                                Button("Update Limit Expenses") {
//                                    showingAdditionalLimit.toggle()
//                                    dismiss()
//                                }
//                                Button("Cancel") {
//                                    dismiss()
//                                }
//                            }
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
                                        
                                })
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
