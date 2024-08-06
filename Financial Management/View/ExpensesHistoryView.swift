//
//  ExpensesView.swift
//  Financial Management
//
//  Created by Pramudya Prameswara Trisna Saputra on 19/10/22.
//

import SwiftUI

struct ExpensesHistoryView: View {
    @ObservedObject var expenses : ExpensesSaveViewModel
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    var body: some View {
        Form{
            Section{
                
            }
            List{
                ForEach(expenses.items) {
                    item in
                    HStack{
                        if item.name == "" {
                            VStack(alignment: .leading){
                                //                                                Text(item.name)
                                Text(LocalizedStringKey(item.whatFor))
                                //                                                    .font(.callout)
                                Text("\(item.date.formatted(date: .complete, time: .shortened))")
                                    .foregroundColor(.secondary)
                                    .font(.footnote)
                                
                                Spacer()
                            }
                            Spacer()
                            VStack{
                                Text("Rp \(item.expense)")
                                Spacer()
                            }
                        } else {
                            VStack(alignment: .leading){
                                Text(item.name)
                                    .lineLimit(2)
                                Text(LocalizedStringKey(item.whatFor))
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                                    .lineLimit(2)
                                Text("\(item.date.formatted(date: .complete, time: .shortened))")
                                    .foregroundColor(.secondary)
                                    .font(.footnote)
                                    .lineLimit(2)
                                Spacer()
                            }
                            Spacer()
                            VStack{
                                Text("Rp \(item.expense)")
                                    .lineLimit(2)
                                Spacer()
                            }
                            
                        }
                    }
                }
                .onDelete(perform: removeItems)
            }
        }
        .navigationTitle("Expenses History")
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
