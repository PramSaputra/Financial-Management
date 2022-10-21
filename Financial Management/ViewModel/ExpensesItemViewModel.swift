//
//  ExpensesItemViewModel.swift
//  Financial Management
//
//  Created by Pramudya Prameswara Trisna Saputra on 19/10/22.
//

import Foundation

struct ExpensesItemViewModel: Identifiable, Codable{
    var id = UUID()
    let name : String
    let whatFor : String
    let expense : Int
}
