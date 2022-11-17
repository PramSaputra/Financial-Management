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
//        init (expenses : ExpensesSaveViewModel){
//            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.init(Color.black)]
//            self.expenses = expenses
//        }
    
    var body: some View {
//        NavigationView{
//            ZStack{
                Form{
                    Section{
                        
                    }
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
                    }
                }
                .navigationTitle("Expenses History")
                    .toolbar{
                        EditButton()
//                    }
                    
            }
//        }
//                    .navigationAppearance(backgroundColor: .systemBlue, foregroundColor: .systemRed)
    }
}

struct ExpensesHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesHistoryView(expenses: ExpensesSaveViewModel())
    }
}
