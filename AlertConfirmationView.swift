//
//  AlertConfirmationView.swift
//  Financial Management
//
//  Created by Pramudya Prameswara Trisna Saputra on 25/10/22.
//

import SwiftUI

struct AlertConfirmationView: View {
    @ObservedObject var popUp : incomeViewModel
    @ObservedObject var onboard4 : FirstViewModel
    var body: some View {
        ZStack{
//            NavigationLink("", destination: MainView(sisaUang: popUp, currentIncome: popUp.monthlyIncome, limitIncome: popUp.limitExpenses), isActive: $onboard4.onboard)
            if popUp.showPopUp == true {
                ZStack {
                    Color.white
                        VStack {
                            Spacer()
                                .frame(height: 50)
                            Text("Is This All Correct?")
                            Spacer()
                                .frame(height: 50)
                            Divider()
                            HStack{
                                VStack{
                                    Button(action: {
                                        withAnimation{
                                            self.popUp.showPopUp = false
                                        }
                                        
                                    }, label: {
                                        Text("Close")
                                    })
                                }.padding()
                                    .background(.gray)
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
                            }.padding()
                                    .background((popUp.limitExpenses == 0 || popUp.limitExpenses == nil) ? Color.gray : Color.orange)
                                    .foregroundColor(.white)
                                    .cornerRadius(20)
                                    .padding()
                            }
                        }.padding()
                }
                .frame(width: 300, height: 200)
                .cornerRadius(20).shadow(radius: 20)
            }
        }
    }
}

struct AlertConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        AlertConfirmationView(popUp: incomeViewModel(), onboard4: FirstViewModel())
    }
}
