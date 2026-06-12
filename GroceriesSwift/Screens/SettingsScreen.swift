//
//  SettingsScreen.swift
//  GroceriesSwift
//
//  Created by Antoine ROY on 08/05/2026.
//

import SwiftUI
import SwiftData

struct SettingsScreen: View {
    @Binding var selectedTab: Int
    @Environment(\.modelContext) private var modelContext
    
    var viewModel = SettingsViewModel()
    @State var showingAlert: Bool = false
    
    private func settingsContent(groceryList: GroceryList) -> some View {
        List {
            Section("Data") {
                SettingsRow(title: "Items in basket", subtitle: "\(viewModel.inBasketItems.count) of \(viewModel.itemCount)", icon: "clock", state: .base)
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
                viewModel.clearAll(context: modelContext)
                selectedTab = 0
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("This action is going to remove all the items you added in your list. Make sure you are done with your groceries first.")
        }
    }
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .error, .loading:
                ProgressView()
            case .ready(let groceryList):
                settingsContent(groceryList: groceryList)
            }
        }
        .task {
            await viewModel.load(context: modelContext)
        }
    }
}

#Preview {
    SettingsScreen(selectedTab: .constant(0))
}
