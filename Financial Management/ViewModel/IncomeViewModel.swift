//
//  MonthlyIncomeViewModel.swift
//  Financial Management
//
//  Created by Pramudya Prameswara Trisna Saputra on 06/10/22.
//

import Foundation

class incomeViewModel: ObservableObject {
    @Published var monthlyIncome : Int? = nil
    @Published var limitExpenses : Int? = nil
    @Published var currentExpenses : Int? = nil
    @Published var onboard : Bool = true
    
}
