//
//  FirstView.swift
//  Financial Management
//
//  Created by Pramudya Prameswara Trisna Saputra on 24/10/22.
//

import SwiftUI

struct FirstView: View {
    @StateObject var vm = incomeModel()
    @StateObject var mainOnboard = FirstViewModel()

    
    
    var body: some View{
        if mainOnboard.onboard == false {
            DashboardStartUpView(onboard1: mainOnboard, incomeViewModel: vm)
               
                .navigationAppearance(backgroundColor: UIColor.init(Color("Primary")), foregroundColor: .white)
//                .environment(\.colorScheme, .dark)
        } else {
            MainView(sisaUang: vm, currentIncome: vm.monthlyIncome ?? 0, limitIncome: vm.limitExpenses ?? 0)
//                .navigationAppearance(backgroundColor: UIColor.init(Color("Primary")), foregroundColor: .white)
//                .environment(\.colorScheme, .dark)
        }
    }
}

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView()
    }
}
