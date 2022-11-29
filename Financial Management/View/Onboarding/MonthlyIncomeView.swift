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
    @State var showPopUp1 = false
    @State var showPopUp2 = false
    @FocusState var buttonDone: Bool
    
    
    var body: some View {
        //   NavigationView{
        
            ZStack {
                if showPopUp1 == true{
                    VStack{
                        Text("Input Your Monthly Income Here")
                        
                        Spacer()
                            .frame(height: 50)
                        
                        TextField("0", value: $ViewModel.monthlyIncome, format:.currency(code: Locale.current.currencyCode ?? "id_ID"))
                            .focused($buttonDone)
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
                                    showPopUp1.toggle()
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
                            .focused($buttonDone)
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
                                    showPopUp1.toggle()
                                }
                            })
                            .padding()
                            .frame(width: 250)
                            .background((ViewModel.limitExpenses == 0 || ViewModel.limitExpenses == nil) ? Color("Primary") : Color("Primary"))
                            .foregroundColor(.white)
                            .cornerRadius(20)
                        }
                        
                    }.navigationTitle("Monthly Income")
                        .toolbar{
                            ToolbarItemGroup(placement: .keyboard) {
                                Spacer()
                                Button("Done") {
                                    buttonDone = false
                                }.foregroundColor(.blue)
                            }
                        }
                }
            }
        
        ZStack{
            NavigationLink("",destination: LimitExpensesView(ViewModel: ViewModel, onboard3: onboard2), isActive: $showPopUp2)
        }
        .alert(isPresented: $showPopUp1){
            Alert(title: Text("Double Check Your Monthly Income"), message: Text("Your Monthly Income are \(ViewModel.monthlyIncome ?? 0)"), primaryButton:.destructive(Text("Continue")){
                self.showPopUp2 = true
            }, secondaryButton: .cancel(Text("Cancel")))
        }
    }
}

struct MonthlyIncomeView_Previews: PreviewProvider {
    static var previews: some View {
        MonthlyIncomeView(ViewModel: incomeModel(), onboard2: FirstViewModel())
    }
}
