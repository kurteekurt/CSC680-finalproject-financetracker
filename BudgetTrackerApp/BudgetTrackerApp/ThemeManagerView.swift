//
//  ThemeManagerView.swift
//  BudgetTrackerApp
//
//  Created by Christian Kurt Balais on 5/9/25.
//

import SwiftUI

enum AppTheme: String, CaseIterable, Identifiable {
    case system, light, dark

    var id: String { rawValue }

    var colorScheme: ColorScheme? {
        switch self {
        case .system: return nil
        case .light: return .light
        case .dark: return .dark
        }
    }
}

struct ThemeManagerView: View {
    @AppStorage("selectedTheme") private var selectedTheme: AppTheme = .system

    var body: some View {
        NavigationView {
            Form {
                Picker("App Theme", selection: $selectedTheme) {
                    ForEach(AppTheme.allCases) { theme in
                        Text(theme.rawValue.capitalized).tag(theme)
                    }
                }
            }
            .navigationTitle("Theme Settings")
        }
        .preferredColorScheme(selectedTheme.colorScheme)
    }
}
