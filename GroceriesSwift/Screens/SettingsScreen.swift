//
//  SettingsScreen.swift
//  GroceriesSwift
//
//  Created by Antoine ROY on 08/05/2026.
//

import SwiftUI

struct SettingsScreen: View {
    var body: some View {
        NavigationView {
            List {
                Section("Data") {
                    SettingsRow(title: "Items in basket", subtitle: "2 of 5", icon: "clock", state: .base)
                    SettingsRow(title: "Clear basket", icon: "checkmark", state: .complete)
                    SettingsRow(title: "Delete all items", icon: "trash", state: .delete)
                }
                
                Section("About") {
                    SettingsRow(title: "Groceries", subtitle: "v1.0", icon: "gear", state: .base)
                }
            }
            .navigationBarTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SettingsScreen()
}
