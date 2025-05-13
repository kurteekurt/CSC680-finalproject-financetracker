//
//  TransactionListView.swift
//  BudgetTrackerApp
//
//  Created by Christian Kurt Balais on 5/9/25.
//

import SwiftUI
import CoreData

struct TransactionListView: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \BudgetTrackerApp.Transaction.date, ascending: false)],
        animation: .default)
    private var transactions: FetchedResults<BudgetTrackerApp.Transaction>

    var body: some View {
        List {
            ForEach(transactions) { transaction in
                VStack(alignment: .leading) {
                    Text(transaction.title ?? "Untitled")
                        .font(.headline)
                    HStack {
                        Text(transaction.category ?? "Uncategorized")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Spacer()
                        Text("$\(transaction.amount, specifier: "%.2f")")
                            .bold()
                    }
                    Text(transaction.date ?? Date(), style: .date)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}
