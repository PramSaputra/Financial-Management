//
//  MonthlyIncomeView.swift
//  Financial Management
//
//  Created by Pramudya Prameswara Trisna Saputra on 05/10/22.
//

import SwiftUI

struct MonthlyIncomeView: View {
    @ObservedObject var ViewModel : incomeModel
    @ObservedObject var onboard2 : FirstViewModel

    var body: some View {
     //   NavigationView{
        
        ZStack{
            ZStack {
//                GeometryReader { reader in
//                    Color("Primary")
//                        .frame(height: reader.safeAreaInsets.top, alignment: .top)
//                        .ignoresSafeArea()
//                }
            if ViewModel.showPopUp1 == true{
                VStack{
                    Text("Input Your Monthly Income Here")
                    
                    Spacer()
                        .frame(height: 50)
                    
                    TextField("0", value: $ViewModel.monthlyIncome, format:.currency(code: Locale.current.currencyCode ?? "id_ID"))
                        .keyboardType(.numberPad)
                        .padding()
                        .frame(width: 250)
                        .background(.quaternary)
                        .cornerRadius(20)
                    Spacer()
                        .frame(height: 50)
                    
                    
                    if ViewModel.monthlyIncome == nil || ViewModel.monthlyIncome == 0 {
                        NavigationLink(("Skip"), destination: LimitExpensesView(ViewModel: ViewModel, onboard3: onboard2))
                            .padding()
                            .frame(width: 250)
                            .background(ViewModel.monthlyIncome == nil || ViewModel.monthlyIncome == 0 ? Color("Primary") : Color("Primary"))
                            .foregroundColor(.white)
                            .cornerRadius(20)
                    } else {
                        Button("Confirm", action: {
                            withAnimation{
                                ViewModel.showPopUp1.toggle()
                            }
                        })
                        .padding()
                        .frame(width: 250)
                        .background((ViewModel.limitExpenses == 0 || ViewModel.limitExpenses == nil) ? Color("Primary") : Color("Primary"))
                        .foregroundColor(.white)
                        .cornerRadius(20)
                    }
                    
                }.blur(radius: 20)
                    .navigationBarBackButtonHidden(true)
            } else {
                VStack{
                    Text("Input Your Monthly Income Here")
                    
                    Spacer()
                        .frame(height: 50)
                    
                    TextField("0", value: $ViewModel.monthlyIncome, format:.currency(code: Locale.current.currencyCode ?? "id_ID"))
                        .keyboardType(.numberPad)
                        .padding()
                        .frame(width: 250)
                        .background(.quaternary)
                        .cornerRadius(20)
                    Spacer()
                        .frame(height: 50)
                    
                    
                    if ViewModel.monthlyIncome == nil || ViewModel.monthlyIncome == 0 {
                        NavigationLink(("Skip"), destination: LimitExpensesView(ViewModel: ViewModel, onboard3: onboard2))
                            .padding()
                            .frame(width: 250)
                            .background(ViewModel.monthlyIncome == nil || ViewModel.monthlyIncome == 0 ? Color("Primary") : Color("Primary"))
                            .foregroundColor(.white)
                            .cornerRadius(20)
                        
                        
                    } else {
                        Button("Confirm", action: {
                            withAnimation{
                                ViewModel.showPopUp1.toggle()
                            }
                        })
                        .padding()
                        .frame(width: 250)
                        .background((ViewModel.limitExpenses == 0 || ViewModel.limitExpenses == nil) ? Color("Primary") : Color("Primary"))
                        .foregroundColor(.white)
                        .cornerRadius(20)
                    }
                    
                }.navigationTitle("Monthly Income")
            }
                VStack{
            if ViewModel.showPopUp1 == true{
                    AlertMonthlyIncomeView(popUp1: ViewModel, onboard5: onboard2)
            }
                    Spacer()
                        .frame(height: 75)
            }
        }
                            
            
     //   }.navigationBarHidden(true)
        
        }
        
    }
}

struct MonthlyIncomeView_Previews: PreviewProvider {
    static var previews: some View {
        MonthlyIncomeView(ViewModel: incomeModel(), onboard2: FirstViewModel())
    }
}
