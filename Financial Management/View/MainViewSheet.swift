//
//  MainViewSheet.swift
//  Financial Management
//
//  Created by Pramudya Prameswara Trisna Saputra on 22/11/22.
//

import SwiftUI

struct MainViewSheet: View {
    @ObservedObject var yourOutcome: incomeModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    Spacer()
                    Button("Your Limit Expenses") {
                        withAnimation{
                            yourOutcome.updateLimit.toggle()
                            dismiss()
                        }
                    }
                    .padding()
                        .foregroundColor(Color("Fifth"))
//                        .background(Color("Primary"))
//                        .cornerRadius(20)
                    Divider()
                        .background(.gray)
//                    HStack{
//                        Spacer()
//
//                    }
                    
                        Button("Your Monthly Income") {
                            withAnimation{
                                yourOutcome.updateMonthly.toggle()
                                dismiss()
                            }
                        }
                        .padding()
                            .foregroundColor(Color("Fifth"))
    //                        .background(Color("Primary"))
    //                        .cornerRadius(20)
                        Divider()
                        .background(.gray)
//                        Spacer()
//                    HStack{
//                    }
                    
                        Button("New Expenses") {
                            withAnimation{
                                yourOutcome.addExpenses.toggle()
                                dismiss()
                            }
                        }
                        .padding()
                            .foregroundColor(Color("Fifth"))
        //                    .background(Color("Primary"))
    //                        .cornerRadius(20)
                        Divider()
                        .background(.gray)
//                    HStack{
//                        Spacer()
//                    }
                    
                }
            }
                .navigationBarTitle("What do you want to update?", displayMode: .inline)
                .navigationBarItems(leading: Button("Back"){
                    dismiss()
                })
        }
    }
}

struct MainViewSheet_Previews: PreviewProvider {
    static var previews: some View {
        MainViewSheet(yourOutcome: incomeModel())
    }
}
