//
//  AlertMonthlyIncomeView.swift
//  Financial Management
//
//  Created by Pramudya Prameswara Trisna Saputra on 31/10/22.
//

import Foundation
import SwiftUI

struct AlertMonthlyIncomeView: View{
    @ObservedObject var popUp1 : incomeModel
    @ObservedObject var onboard5 : FirstViewModel
    var body: some View{
        ZStack{
            if popUp1.showPopUp1{
                ZStack {
                    Color.white
                        VStack {
                            Spacer()
                                .frame(height: 30)
                            Text("Double Check Your Monthly Income")
                                .foregroundColor(.black)
                                .font(Font.body.bold())
                            Spacer()
                                .frame(height: 5)
                            Text("Your Monthly Income are \(popUp1.monthlyIncome ?? 0)")
                                .foregroundColor(.black)
                            Spacer()
                                .frame(height: 30)
                            Divider()
                            HStack{
                                Spacer()
                                VStack{
                                    Button(action: {
                                        withAnimation{
                                            self.popUp1.showPopUp1 = false
                                        }
                                        
                                    }, label: {
                                        Text("Close")
                                    })
                                }.foregroundColor(.red)
                                .cornerRadius(20)
                                Spacer()
                                Divider()
                                Spacer()
                                VStack{
                                    ZStack{
                                        NavigationLink(("Confirm"), destination: LimitExpensesView(ViewModel: popUp1, onboard3: onboard5))
                                    }.foregroundColor(Color("Primary"))
                            }.cornerRadius(20)
                                    Spacer()
                            }
                        }
                }
                .frame(width: 300, height: 160)
                .cornerRadius(20).shadow(radius: 20)
            }
        }
    }
}
