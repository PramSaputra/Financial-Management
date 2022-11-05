//
//  ExpensesView.swift
//  Financial Management
//
//  Created by Pramudya Prameswara Trisna Saputra on 19/10/22.
//

import SwiftUI

struct ExpensesHistoryView: View {
    @StateObject var expenses : ExpensesSaveViewModel
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    var body: some View {
        List{
            ForEach(expenses.items) {
                item in
                HStack{
                    VStack(alignment: .leading){
                        Text(item.name)
                        Text(item.whatFor)
                    }
                    Spacer()
                    Text("Rp \(item.expense)")
                }
            }
            .onDelete(perform: removeItems)
        }.navigationTitle("Expenses History")
            .toolbar{
                EditButton()
            }
    }
}

struct ExpensesHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesHistoryView(expenses: ExpensesSaveViewModel())
    }
}
