//
//  ContentView.swift
//  BudgetTrackerApp
//
//  Created by Christian Kurt Balais on 5/9/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            TransactionListView()
                .tabItem {
                    Label("Transactions", systemImage: "list.bullet")
                }
                .tag(0)


            ChartsView()
                .tabItem {
                    Label("Charts", systemImage: "chart.bar")
                }
                .tag(1)
            
            AddTransactionView(selectedTab: $selectedTab)
                .environment(\.managedObjectContext, viewContext)
                .tabItem {
                    Label("Add", systemImage: "plus.circle")
                }
                .tag(2)

            SearchBarView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                .tag(3)

            ThemeManagerView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag(4)
            
            IncomeExpenseSummaryView()
                .tabItem {
                    Label("Summary", systemImage: "arrow.left.arrow.right.circle")
                }
                .tag(5)
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
