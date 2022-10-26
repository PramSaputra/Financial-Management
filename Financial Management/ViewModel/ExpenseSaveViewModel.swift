//
//  ExpenseSaveViewModel.swift
//  Financial Management
//
//  Created by Pramudya Prameswara Trisna Saputra on 19/10/22.
//

import Foundation

class ExpensesSaveViewModel: ObservableObject{
    @Published var items = [ExpensesItemViewModel](){
        didSet {
           let encoder = JSONEncoder()
            
           if let encoded = try? encoder.encode(items) {
               UserDefaults.standard.set(encoded, forKey: "Items")
           }
       }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items"){
            if let decodedItems = try? JSONDecoder().decode([ExpensesItemViewModel].self, from: savedItems) {
             items = decodedItems
             return
            }
        }
        items = []
    }
}
