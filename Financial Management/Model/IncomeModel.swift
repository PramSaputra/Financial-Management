//
//  MonthlyIncomeViewModel.swift
//  Financial Management
//
//  Created by Pramudya Prameswara Trisna Saputra on 06/10/22.
//

import Foundation
import SwiftUI

class incomeModel: ObservableObject {
    @AppStorage (expensesKey.monthly.rawValue) var monthlyIncome : Int?
    @AppStorage (expensesKey.limit.rawValue) var limitExpenses : Int?
    @AppStorage ("CurrentExpenses") var currentExpenses : Int?
//    @Published  var monthlyIncome : Int? = nil
//    @Published  var limitExpenses : Int? = nil
//    @Published  var currentExpenses : Int? = nil
    @Published var showPopUp1 : Bool = false
    @Published var showPopUp2 : Bool = false
    @Published var zeroValue : Bool = false
    @Published var updateLimit : Bool = false
    @Published var updateMonthly : Bool = false
    @Published var addExpenses : Bool = false
    
    
    
}

enum expensesKey: String, CaseIterable{
    case monthly = "MonthlyIncome"
    case limit = "LimitExpenses"
}
extension UserDefaults{
    func monthlyreset(){
        expensesKey.allCases.forEach{
            removeObject(forKey: $0.rawValue)
        }
    }
}

//    UserDefaults.standard.monthlyreset()
//buat manggil monthly reset
