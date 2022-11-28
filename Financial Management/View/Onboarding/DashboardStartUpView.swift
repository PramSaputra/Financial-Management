//
//  ContentView.swift
//  Financial Management
//
//  Created by Pramudya Prameswara Trisna Saputra on 04/10/22.
//

import SwiftUI
import CoreData



struct DashboardStartUpView: View {
    @ObservedObject var onboard1 : FirstViewModel
    @ObservedObject var incomeViewModel : incomeModel
    
    var body: some View {
        NavigationView {
            ZStack {
//                GeometryReader { reader in
//                    Color("Primary")
//                        .frame(height: reader.safeAreaInsets.top, alignment: .top)
//                        .ignoresSafeArea()
//                }
            VStack{
                Image(systemName: "dollarsign.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
                    .foregroundColor(Color("Primary"))
                    .cornerRadius(150)
                Spacer()
                    .frame(height: 50)
                
                Text("Start your budgeting now")
                    .padding()
                
                Spacer()
                    .frame(height: 20)
                
                NavigationLink(("Let's Get Started"), destination: MonthlyIncomeView(ViewModel: incomeViewModel, onboard2: onboard1))
                    .padding()
                    .background(Color("Primary"))
                    .foregroundColor(.white)
                    .cornerRadius(20)
            }.navigationTitle("Dashboard")
//                    .foregroundColor(Color("Normal"))
        }
        }.accentColor(Color.white)
    }
}

struct DashboardStartUpView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardStartUpView(onboard1: FirstViewModel(), incomeViewModel: incomeModel())
            .environment(\.locale, .init(identifier: "id"))
        
        DashboardStartUpView(onboard1: FirstViewModel(), incomeViewModel: incomeModel())
    }
}
