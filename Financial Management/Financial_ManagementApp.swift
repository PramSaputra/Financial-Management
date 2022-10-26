//
//  Financial_ManagementApp.swift
//  Financial Management
//
//  Created by Pramudya Prameswara Trisna Saputra on 04/10/22.
//

import SwiftUI

@main
struct Financial_ManagementApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            FirstView(mainOnboard: FirstViewModel())
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
