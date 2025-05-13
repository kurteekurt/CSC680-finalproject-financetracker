//
//  SearchBarView.swift
//  BudgetTrackerApp
//
//  Created by Christian Kurt Balais on 5/9/25.
//

import SwiftUI
import CoreData

struct SearchBarView: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Transaction.date, ascending: false)],
        animation: .default
    ) private var transactions: FetchedResults<Transaction>

    @State private var searchText: String = ""

    var filteredTransactions: [Transaction] {
        if searchText.isEmpty { return Array(transactions) }
        return transactions.filter {
            ($0.title?.localizedCaseInsensitiveContains(searchText) ?? false) ||
            ($0.category?.localizedCaseInsensitiveContains(searchText) ?? false)
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                TextField("Search...", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                List(filteredTransactions) { txn in
                    VStack(alignment: .leading) {
                        Text(txn.title ?? "")
                            .font(.headline)
                        HStack {
                            Text(txn.category ?? "")
                            Spacer()
                            Text("$\(txn.amount, specifier: "%.2f")")
                        }
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("Search Transactions")
        }
    }
}
