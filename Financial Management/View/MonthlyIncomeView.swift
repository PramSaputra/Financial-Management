//
//  MonthlyIncomeView.swift
//  Financial Management
//
//  Created by Pramudya Prameswara Trisna Saputra on 05/10/22.
//

import SwiftUI

struct MonthlyIncomeView: View {
    @StateObject var ViewModel = incomeViewModel()
 
    var body: some View {
     //   NavigationView{
            VStack{
                Text("Input Your Monthly Income Here")
                
                Spacer()
                    .frame(height: 50)
                
                TextField("0", value: $ViewModel.monthlyIncome, format:.currency(code: Locale.current.currencyCode ?? "id_ID"))
                    .keyboardType(.numberPad)
                    .padding()
                    .frame(width: 250)
                    .background(.yellow)
                    .cornerRadius(20)
                Spacer()
                    .frame(height: 50)
                
                NavigationLink(("Confirm"), destination: LimitExpensesView(income: ViewModel.monthlyIncome ?? 0))
                    .padding()
                    .frame(width: 250)
                    .background(ViewModel.monthlyIncome == nil || ViewModel.monthlyIncome == 0 ? Color.gray : Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    .disabled(ViewModel.monthlyIncome == nil || ViewModel.monthlyIncome == nil)
            }.navigationTitle("Monthly Income")
                
            
     //   }.navigationBarHidden(true)
        
        
        
    }
}

struct MonthlyIncomeView_Previews: PreviewProvider {
    static var previews: some View {
        MonthlyIncomeView()
    }
}
