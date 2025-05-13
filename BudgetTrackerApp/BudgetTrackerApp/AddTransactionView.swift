//
//  AddTransactionView.swift
//  BudgetTrackerApp
//
//  Created by Christian Kurt Balais on 5/9/25.
//

import SwiftUI

struct AddTransactionView: View {
    @Binding var selectedTab: Int
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var title: String = ""
    @State private var amount: String = ""
    @State private var category: String = ""
    @State private var date: Date = Date()
    @State private var type: String = "Expense"

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Details")) {
                    TextField("Title", text: $title)
                    TextField("Amount", text: $amount)
                        .keyboardType(.decimalPad)
                    
                    Picker("Type", selection: $type) {
                        Text("Expense").tag("Expense")
                        Text("Income").tag("Income")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    TextField("Category", text: $category)
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                }

                Button("Save") {
                    saveTransaction()
                    dismiss()
                }
                .disabled(title.isEmpty || Double(amount) == nil)
            }
            .navigationTitle("New Transaction")
        }
    }

    private func saveTransaction() {
        let newTransaction = BudgetTrackerApp.Transaction(context: viewContext)
        newTransaction.id = UUID()
        newTransaction.title = title
        newTransaction.amount = Double(amount) ?? 0.0
        newTransaction.category = category
        newTransaction.date = date
        newTransaction.type = type

        do {
            try viewContext.save()
        } catch {
            print("Failed to save transaction: \(error)")
        }
    }
}
