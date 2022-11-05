//
//  AlertConfirmationView.swift
//  Financial Management
//
//  Created by Pramudya Prameswara Trisna Saputra on 25/10/22.
//

import SwiftUI

struct AlertConfirmationLimitView: View {
    @ObservedObject var popUp2 : incomeModel
    @ObservedObject var onboard4 : FirstViewModel
    var body: some View {
        ZStack{
//            NavigationLink("", destination: MainView(sisaUang: popUp, currentIncome: popUp.monthlyIncome, limitIncome: popUp.limitExpenses), isActive: $onboard4.onboard)
            if popUp2.showPopUp2{
                ZStack {
                    Color.white
                        VStack {
                            Spacer()
                                .frame(height: 50)
                            Text("Is This All Correct?")
                            Spacer()
                            Text("Your Limit Expenses are \(popUp2.limitExpenses ?? 0)")
                                .frame(height: 70)
                            Divider()
                            HStack{
                                Spacer()
                                VStack{
                                    Button(action: {
                                        withAnimation{
                                            self.popUp2.showPopUp2 = false
                                            self.popUp2.limitExpenses = popUp2.limitExpenses
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
                                        Button("Confirm", action: {
                                            withAnimation{
                                                onboard4.onboard.toggle()
                                        }
                                    })
                                }
                            }.cornerRadius(20)
                                    Spacer()
                            }
                        }
                }
                .frame(width: 300, height: 200)
                .cornerRadius(20).shadow(radius: 20)
            }
        }
    }
}

struct AlertConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        AlertConfirmationLimitView(popUp2: incomeModel(), onboard4: FirstViewModel())
    }
}
