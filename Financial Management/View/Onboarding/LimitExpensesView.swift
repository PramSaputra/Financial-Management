//
//  LimitExpensesView.swift
//  Financial Management
//
//  Created by Pramudya Prameswara Trisna Saputra on 05/10/22.
//

import SwiftUI

struct LimitExpensesView: View {
    @ObservedObject var ViewModel : incomeModel
    @ObservedObject var onboard3 : FirstViewModel
    @State var aktif = false
    @State var limit = 0
    let limitPercentage = [50, 60, 70, 80]
    @State var showPopUp1 = false
    @State var showPopUp2 = false
    @FocusState var buttonDone: Bool
    
    var body: some View {
        //     NavigationView{
        
        ZStack {
            if showPopUp2 == true{
                VStack{
                    Text("Set Your Monthly Limit Expenses Here")
                    Spacer()
                        .frame(height: 50)
                    
                    Text("Your Monthly Income are Rp \(ViewModel.monthlyIncome ?? 0)")
                    
                    TextField("0", value: ($ViewModel.limitExpenses), format:.currency(code:Locale.current.currencyCode ?? "id_ID"))
                        .keyboardType(.numberPad)
                        .focused($buttonDone)
                        .padding()
                        .frame(width: 250)
                        .background(.quaternary)
                        .cornerRadius(20)
                    
                    Text("Recomendation")
                    
                    Picker("Select Your Limit", selection: $limit) {
                        ForEach(limitPercentage, id: \.self){                        Text(" \($0)%")
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    Group{
                        if onboard3.onboard == false {
                            Button("Confirm", action: {
                                showPopUp2.toggle()
                                
                            })
                            .padding()
                            .frame(width: 250)
                            .background((ViewModel.limitExpenses == 0 || ViewModel.limitExpenses == nil) ? Color.gray : Color("Primary"))
                            .foregroundColor(.white)
                            .cornerRadius(20)
                            .padding(50)
                            .disabled(ViewModel.limitExpenses == 0)
                            .disabled(ViewModel.limitExpenses == nil)
                        }
                    }
                }
                .blur(radius: 20)
                .navigationBarBackButtonHidden(true)
            } else {
                VStack{
                    Text("Set Your Monthly Limit Expenses Here")
                    Spacer()
                        .frame(height: 50)
                    
                    Text("Your Monthly Income are Rp \(ViewModel.monthlyIncome ?? 0)")
                    
                    TextField("0", value: ($ViewModel.limitExpenses), format:.currency(code:Locale.current.currencyCode ?? "id_ID"))
                        .keyboardType(.numberPad)
                        .focused($buttonDone)
                        .padding()
                        .frame(width: 250)
                        .background(.quaternary)
                        .cornerRadius(20)
                        .onAppear{
                            let limitExpensesPercent = limit
                            let income = ViewModel.monthlyIncome
                            let limit = ViewModel.limitExpenses
                            
                            let trueLimit = (limit ?? 0)
                            
                            let limitedExpenses = (income ?? 0) / 100 * (limitExpensesPercent )
                            
                            
                            
                            if income == nil || income == 0 {
                                self.ViewModel.limitExpenses = trueLimit;
                                //                                    self.ViewModel.showPopUp1 = false
                                print("sukses 3")
                            }
                            else {
                                self.ViewModel.limitExpenses = trueLimit;
                                //                                    self.ViewModel.showPopUp1 = false
                                print("gagal 3")
                            }
                        }
                    
                    Text("Recomendation")
                    HStack{
                        Picker("Select Your Limit", selection: $limit) {
                            ForEach(limitPercentage, id: \.self){                        Text(" \($0)% ")
                            }
                        }
                    }
                    .pickerStyle(.segmented)
                    //                    .background(Color("Third"))
                    
                    .onChange(of: limit, perform: { (value) in
                        let limitExpensesPercent = limit
                        let income = ViewModel.monthlyIncome
                        let limit = ViewModel.limitExpenses
                        
                        let trueLimit = (limit ?? 0)
                        
                        let limitedExpenses = (income ?? 0) / 100 * (limitExpensesPercent )
                        
                        
                        
                        if income == nil || income == 0 {
                            self.ViewModel.limitExpenses = trueLimit;
                            //                                self.ViewModel.showPopUp1 = false
                            print("sukses 4")
                        }
                        else {
                            self.ViewModel.limitExpenses = limitedExpenses;
                            //                                self.ViewModel.showPopUp1 = false
                            print("gagal 4")
                        }
                    })
                    
                    Group{
                        
                        if onboard3.onboard == false {
                            Button("Confirm", action: {
                                withAnimation{
                                    showPopUp2.toggle()
                                }
                            })
                            .padding()
                            .frame(width: 250)
                            .background((ViewModel.limitExpenses == 0 || ViewModel.limitExpenses == nil) ? Color.gray : Color("Primary"))
                            .foregroundColor(.white)
                            .cornerRadius(20)
                            .padding(50)
                            .disabled(ViewModel.limitExpenses == 0)
                            .disabled(ViewModel.limitExpenses == nil)
                        }
                    }
                }.navigationTitle("Limit Expenses")
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
        .alert(isPresented: $showPopUp2){
            Alert(title: Text("Double Check Your Monthly Expenses"), message: Text("Your Limit Expenses are \(ViewModel.limitExpenses ?? 0)"), primaryButton:.destructive(Text("Continue")){
                withAnimation{
                    onboard3.onboard.toggle()
                }
            }, secondaryButton: .cancel(Text("Cancel")))
        }
    }
}

struct LimitExpensesView_Previews: PreviewProvider {
    static var previews: some View {
        LimitExpensesView(ViewModel: incomeModel(), onboard3: FirstViewModel())
    }
}
