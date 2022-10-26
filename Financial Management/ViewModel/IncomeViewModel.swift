//
//  MonthlyIncomeViewModel.swift
//  Financial Management
//
//  Created by Pramudya Prameswara Trisna Saputra on 06/10/22.
//

import Foundation
import SwiftUI

class incomeViewModel: ObservableObject {
    @AppStorage ("MonthlyIncome") var monthlyIncome : Int = 0
    @AppStorage ("LimitExpenses") var limitExpenses : Int = 0
    @AppStorage ("CurrentExpenses") var currentExpenses : Int = 0
    @Published var showPopUp : Bool = false
}
