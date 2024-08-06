//
//  AdditionalLimitView.swift
//  Financial Management
//
//  Created by Pramudya Prameswara Trisna Saputra on 26/10/22.
//

import SwiftUI

struct AdditionalLimitView: View {
    @ObservedObject var income : incomeModel
    @State var money : Int?
    @Environment(\.dismiss) var dismiss
    @State var totalLimit : Int?
    let currentMonthlyIncome : Int
    @FocusState var buttonDone: Bool
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    
                }
                HStack{
                    Text("Your Starting Monthly Income are")
                    Divider()
                    Text("\(income.monthlyIncome ?? 0)")
                }
                Section{
                    TextField("Input Your Total Limit Expenses", value: $totalLimit, format:.currency(code: Locale.current.currency?.identifier ?? "id_ID"))
                        .keyboardType(.numberPad)
                        .focused($buttonDone)
                        .padding()
                        .frame(width: 320)
                        .background(.bar)
                        .cornerRadius(20)
                        .onAppear{
                            if money == 0 || money == nil{
                                self.money = nil
                                self.totalLimit = nil
                            } else{
                                let currentLimit = income.limitExpenses ?? 0
                                let additionalLimit = money ?? 0
                                
                                
                                let trueLimit = currentLimit + additionalLimit
                                
                                self.totalLimit = trueLimit
                            }
                            
                        }
                        .onChange(of: money, perform:{ (value) in
                            let currentLimit = income.limitExpenses ?? 0
                            let additionalLimit = money ?? 0
                            
                            
                            let trueLimit = currentLimit + additionalLimit
                            
                            self.totalLimit = trueLimit
                        })

                    Text("Update Your Limit Expenses Here")
                        .font(.footnote)
                }
                Section{
                    
                    TextField("Input Your Additional Limit Expenses", value: $money, format:.currency(code: Locale.current.currencyCode ?? "id_ID"))
                        .keyboardType(.numberPad)
                        .focused($buttonDone)
                        .padding()
                        .frame(width: 320)
                        .background(.bar)
                        .cornerRadius(20)
                    
                    Text("Add Number Manually To Update Your Limit Expenses")
                        .font(.footnote)
                    
                }
                HStack{
                    Text("Your Current Monthly Income are")
                    Divider()
                    Text("\(currentMonthlyIncome)")
                }
                
            }.navigationTitle("Your Limit Expenses")
                .toolbar{
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            buttonDone = false
                        }.foregroundColor(.blue)
                    }
                }
                .navigationBarItems(leading: Button("Back"){
                    dismiss()
                    
                }, trailing: Button("Save"){
                    dismiss()
                    income.limitExpenses = totalLimit ?? 0
                })
        }
    }
}

struct AdditionalIncomeView: View {
    @ObservedObject var income : incomeModel
    @State var updatedIncome : Int?
    @State var alert = false
    @Environment(\.dismiss) var dismiss
    @FocusState var buttonDone: Bool
    var body: some View {
        NavigationView{
            Form{
                Section{
                    
                }
                Text("Your Limit Expenses are \(income.limitExpenses ?? 0)")
                TextField("\(income.monthlyIncome ?? 0)", value: $updatedIncome, format:.currency(code: Locale.current.currencyCode ?? "id_ID"))
                    .keyboardType(.numberPad)
                    .focused($buttonDone)
                    .padding()
                    .frame(width: 320)
                    .background(.bar)
                    .cornerRadius(20)
                Text("Update Your Monthly Income Here")
                    .font(.footnote)
                
            }.navigationTitle("Your Monthly Income")
                .toolbar{
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            buttonDone = false
                        }.foregroundColor(.blue)
                    }
                }
                .navigationBarItems(leading: Button("Back"){
                    dismiss()
                    
                }, trailing: Button("Save"){
                    
                    if updatedIncome ?? 0 >= income.limitExpenses ?? 0 || income.limitExpenses == nil {
                        dismiss()
                        income.monthlyIncome = updatedIncome ?? 0
                    } else {
                        dismiss()
                    }
                })
        }
    }
}

struct AdditionalLimitView_Previews: PreviewProvider {
    static var previews: some View {
        AdditionalLimitView(income: incomeModel(), currentMonthlyIncome: 1000000)
    }
}
