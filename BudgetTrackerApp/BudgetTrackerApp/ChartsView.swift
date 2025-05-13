//
//  ChartsView.swift
//  BudgetTrackerApp
//
//  Created by Christian Kurt Balais on 5/9/25.
//

import SwiftUI
import Charts
import CoreData

struct CategorySpending: Identifiable {
    let id = UUID()
    let category: String
    let amount: Double
}

struct ChartsView: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Transaction.date, ascending: false)],
        animation: .default
    ) private var transactions: FetchedResults<Transaction>

    var body: some View {
        let grouped = Dictionary(grouping: transactions) { $0.category ?? "Unknown" }
        let data = grouped.map { CategorySpending(category: $0.key, amount: $0.value.reduce(0) { $0 + $1.amount }) }

        NavigationView {
            Chart(data) {
                BarMark(
                    x: .value("Category", $0.category),
                    y: .value("Amount", $0.amount)
                )
            }
            .navigationTitle("Spending by Category")
        }
    }
}
