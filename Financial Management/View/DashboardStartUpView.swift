//
//  ContentView.swift
//  Financial Management
//
//  Created by Pramudya Prameswara Trisna Saputra on 04/10/22.
//

import SwiftUI
import CoreData

struct DashboardStartUpView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    var body: some View {
        NavigationView {
            VStack{
                Image(systemName: "dollarsign.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
                Spacer()
                    .frame(height: 50)
                
                Text("Start your budgeting now")
                    .padding()
                
                Spacer()
                    .frame(height: 20)
                
                NavigationLink(("Let's Get Started"), destination: MonthlyIncomeView())
                    .padding()
                    .background(.orange)
                    .foregroundColor(.white)
            }.navigationTitle("Dashboard")
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct DashboardStartUpView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardStartUpView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
