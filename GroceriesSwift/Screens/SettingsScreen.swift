//
//  SettingsScreen.swift
//  GroceriesSwift
//
//  Created by Antoine ROY on 08/05/2026.
//

import SwiftUI

struct SettingsScreen: View {
    @Environment(\.dismiss) var dismiss
    
    var viewModel: ShoppingListViewModel
    @State var showingAlert: Bool = false
    
    var body: some View {
        List {
            Section("Data") {
                SettingsRow(title: "Items in basket", subtitle: "\(viewModel.inBasketItems.count) of \(viewModel.items.count)", icon: "clock", state: .base)
                    .alignmentGuide(.listRowSeparatorLeading) { _ in 0 }
                SettingsRow(title: "Clear all items", icon: "checkmark", state: .complete) { showingAlert = true }
            }
            
            Section("About") {
                SettingsRow(title: "Groceries", subtitle: "v1.0", icon: "gear", state: .base)
            }
        }
        .navigationBarTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .alert(
            "Are you sure?",
            isPresented: $showingAlert,
        ) {
            Button("Clear all", role: .destructive) {
                viewModel.clearAll()
                dismiss()
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("This action is going to remove all the items you added in your list. Make sure you are done with your groceries first.")
        }
    }
}

#Preview {
    SettingsScreen(viewModel: ShoppingListViewModel())
}
