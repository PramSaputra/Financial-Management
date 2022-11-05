//
//  MonthlyIncomeViewModel.swift
//  Financial Management
//
//  Created by Pramudya Prameswara Trisna Saputra on 06/10/22.
//

import Foundation
import SwiftUI

class incomeModel: ObservableObject {
    @AppStorage ("MonthlyIncome") var monthlyIncome : Int?
    @AppStorage ("LimitExpenses") var limitExpenses : Int?
    @AppStorage ("CurrentExpenses") var currentExpenses : Int?
//    @Published  var monthlyIncome : Int? = nil
//    @Published  var limitExpenses : Int? = nil
//    @Published  var currentExpenses : Int? = nil
    @Published var showPopUp1 : Bool = false
    @Published var showPopUp2 : Bool = false
    @Published var zeroValue : Bool = false
}
