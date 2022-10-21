//
//  LimitExpensesView.swift
//  Financial Management
//
//  Created by Pramudya Prameswara Trisna Saputra on 05/10/22.
//

import SwiftUI

struct LimitExpensesView: View {
    @StateObject var ViewModel = incomeViewModel()
    let income: Int
    @State var limit = 50
    let limitPercentage = [50, 60, 70, 80]
    
    var body: some View {
   //     NavigationView{
            VStack{
                Text("Set Your Monthly Limit Expenses Here")
                Spacer()
                    .frame(height: 50)
                
                Text("Your Monthly Income are Rp \(income)")
                
                TextField("0", value: ($ViewModel.limitExpenses), format:.currency(code:Locale.current.currencyCode ?? "id_ID"))
                    .keyboardType(.numberPad)
                    .padding()
                    .frame(width: 250)
                    .background(.gray)
                    .cornerRadius(20)
                    .foregroundColor(.white)
                    .onAppear{
                        let limitExpensesPercent = limit

                        let limitedExpenses = income / 100 * (limitExpensesPercent )
                        self.ViewModel.limitExpenses = limitedExpenses;
                        self.ViewModel.monthlyIncome = income
                    }
                
                Text("Recomendation")
                
                Picker("Select Your Limit", selection: $limit) {
                    ForEach(limitPercentage, id: \.self){                        Text("Limit \($0)% of Your Income")
                    }
                }.pickerStyle(.menu)
                    .onChange(of: limit, perform: { (value) in
                        let limitExpensesPercent = limit

                        let limitedExpenses = income / 100 * (limitExpensesPercent )
                        self.ViewModel.limitExpenses = limitedExpenses;
                        self.ViewModel.monthlyIncome = income
                    })
                
                Group{
                    NavigationLink(("Confirm"), destination: MainView(currentIncome: ViewModel.monthlyIncome ?? 0, limitIncome: ViewModel.limitExpenses ?? 0))
                        .padding()
                        .frame(width: 250)
                        .background((ViewModel.limitExpenses == 0 || ViewModel.limitExpenses == nil) ? Color.gray : Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                        .padding(50)
                        .disabled(ViewModel.limitExpenses == 0)
                        .disabled(ViewModel.limitExpenses == nil)
                }
                
            }.navigationTitle("Limit Expenses")
       // }.navigationBarHidden(true)
        
        
        
    }
}

struct LimitExpensesView_Previews: PreviewProvider {
    static var previews: some View {
        LimitExpensesView(income: 100000)
    }
}
