//
//  IncomeExpenseSummaryView.swift
//  BudgetTrackerApp
//
//  Created by Christian Kurt Balais on 5/9/25.
//

import SwiftUI
import Charts
import CoreData

struct IncomeExpenseSummaryView: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Transaction.date, ascending: false)],
        animation: .default
    ) private var transactions: FetchedResults<Transaction>

    struct SummaryItem: Identifiable {
        let id = UUID()
        let type: String
        let amount: Double
    }

    var body: some View {
        let income = transactions.filter { $0.type == "Income" }.reduce(0) { $0 + $1.amount }
        let expense = transactions.filter { $0.type == "Expense" }.reduce(0) { $0 + $1.amount }
        let net = income - expense

        let summaryData = [
            SummaryItem(type: "Income", amount: income),
            SummaryItem(type: "Expense", amount: expense)
        ]

        NavigationView {
            VStack(spacing: 16) {
                Text("Income vs Expense")
                    .font(.title2)
                    .bold()

                Chart(summaryData) { item in
                    BarMark(
                        x: .value("Type", item.type),
                        y: .value("Amount", item.amount)
                    )
                    .foregroundStyle(item.type == "Income" ? .green : .red)
                }
                .frame(height: 250)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Total Income: $\(income, specifier: "%.2f")")
                    Text("Total Expenses: $\(expense, specifier: "%.2f")")
                    Text("Net: $\(net, specifier: "%.2f")")
                        .fontWeight(.bold)
                        .foregroundColor(net >= 0 ? .green : .red)
                }
                .padding()

                Spacer()
            }
            .padding()
            .navigationTitle("Summary")
        }
    }
}
