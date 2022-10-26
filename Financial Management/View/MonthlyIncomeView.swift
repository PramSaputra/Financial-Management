//
//  MonthlyIncomeView.swift
//  Financial Management
//
//  Created by Pramudya Prameswara Trisna Saputra on 05/10/22.
//

import SwiftUI

struct MonthlyIncomeView: View {
    @StateObject var ViewModel = incomeViewModel()
    @ObservedObject var onboard2 : FirstViewModel

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
                
                
                if ViewModel.monthlyIncome == nil || ViewModel.monthlyIncome == 0 {
                    NavigationLink(("Skip"), destination: LimitExpensesView(ViewModel: ViewModel, onboard3: onboard2))
                        .padding()
                        .frame(width: 250)
                        .background(ViewModel.monthlyIncome == nil || ViewModel.monthlyIncome == 0 ? Color.orange : Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                    
                    
                } else{
                    NavigationLink(("Confirm"), destination: LimitExpensesView(ViewModel: ViewModel, onboard3: onboard2))
                        .padding()
                        .frame(width: 250)
                        .background(ViewModel.monthlyIncome == nil || ViewModel.monthlyIncome == 0 ? Color.gray : Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                }
                
            }.navigationTitle("Monthly Income")
                
            
     //   }.navigationBarHidden(true)
        
        
        
    }
}

struct MonthlyIncomeView_Previews: PreviewProvider {
    static var previews: some View {
        MonthlyIncomeView(onboard2: FirstViewModel())
    }
}
