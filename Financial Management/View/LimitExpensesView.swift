//
//  LimitExpensesView.swift
//  Financial Management
//
//  Created by Pramudya Prameswara Trisna Saputra on 05/10/22.
//

import SwiftUI

struct LimitExpensesView: View {
    @ObservedObject var ViewModel : incomeViewModel
    @ObservedObject var onboard3 : FirstViewModel
    @State var aktif = false
    @State var limit = 50
    let limitPercentage = [50, 60, 70, 80]
    
    var body: some View {
   //     NavigationView{
        ZStack{
            VStack{
                Text("Set Your Monthly Limit Expenses Here")
                Spacer()
                    .frame(height: 50)
                
                Text("Your Monthly Income are Rp \(ViewModel.monthlyIncome ?? 0)")
                
                TextField("0", value: ($ViewModel.limitExpenses), format:.currency(code:Locale.current.currencyCode ?? "id_ID"))
                    .keyboardType(.numberPad)
                    .padding()
                    .frame(width: 250)
                    .background(.gray)
                    .cornerRadius(20)
                    .foregroundColor(.white)
                    .onAppear{
                        let limitExpensesPercent = limit
                        let income = ViewModel.monthlyIncome
                        
                        let limitedExpenses = (income ?? 0) / 100 * (limitExpensesPercent )
                        
                        self.ViewModel.limitExpenses = limitedExpenses
                    }
                
                Text("Recomendation")
                
                Picker("Select Your Limit", selection: $limit) {
                    ForEach(limitPercentage, id: \.self){                        Text("Limit \($0)% of Your Income")
                    }
                }.pickerStyle(.menu)
                    .onChange(of: limit, perform: { (value) in
                        let limitExpensesPercent = limit
                        let income = ViewModel.monthlyIncome
                        
                        let limitedExpenses = (income ?? 0) / 100 * (limitExpensesPercent )
                        
                        self.ViewModel.limitExpenses = limitedExpenses
                    })
               
                Group{
                    
                    if onboard3.onboard == false {
                        Button("Confirm", action: {
                            ViewModel.showPopUp.toggle()
                            
                        })
                        .padding()
                        .frame(width: 250)
                        .background((ViewModel.limitExpenses == 0 || ViewModel.limitExpenses == nil) ? Color.gray : Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                        .padding(50)
                        .disabled(ViewModel.limitExpenses == 0)
                        .disabled(ViewModel.limitExpenses == nil)
                    }
                }
            }
            if ViewModel.showPopUp == true{
                withAnimation{
                    AlertConfirmationView(popUp: ViewModel, onboard4: onboard3)
                }
            }
        }.navigationTitle("Limit Expenses")}
}

struct LimitExpensesView_Previews: PreviewProvider {
    static var previews: some View {
        LimitExpensesView(ViewModel: incomeViewModel(), onboard3: FirstViewModel())
    }
}
