//
//  BudgetTrackerAppApp.swift
//  BudgetTrackerApp
//
//  Created by Christian Kurt Balais on 5/9/25.
//

import SwiftUI

@main
struct BudgetTrackerAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
