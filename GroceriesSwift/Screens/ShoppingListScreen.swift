//
//  ShoppingListView.swift
//  GroceriesSwift
//
//  Created by Antoine ROY on 28/04/2026.
//

import SwiftUI
import SwiftData

struct ShoppingListScreen: View {
    @Environment(\.modelContext) private var modelContext

    @State private var viewModel = ShoppingListViewModel()
    @State private var showingSheet = false
    @State private var showingSettings = false
    
    private var shoppingList: some View {
        List {
            if viewModel.toBuyItems.count > 0 {
                ShoppingListSection(items: viewModel.toBuyItems, setItemAsBought: viewModel.setItemAsBought, deleteItem: viewModel.deleteItem) {
                    ShoppingListSectionHeader(
                        dotColor: .green,
                        title: "To Buy",
                        subTitle: "\(viewModel.toBuyItems.count)"
                    )
                }
            }
            
            if viewModel.inBasketItems.count > 0 {
                ShoppingListSection(items: viewModel.inBasketItems, setItemAsBought: viewModel.setItemAsBought, deleteItem: viewModel.deleteItem) {
                    ShoppingListSectionHeader(
                        dotColor: .green.opacity(0.5),
                        title: "In Basket",
                        subTitle: "\(viewModel.inBasketItems.count)"
                    )
                }
            }
        }
        .listRowSpacing(-15)
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background(.clear)
        .scrollIndicators(.hidden)
    }
    
    var body: some View {
        VStack {
            ShoppingListHeaderView(totalCount: viewModel.items.count, boughtCount: viewModel.inBasketItems.count, onSettingsPressed: { showingSettings = true }
            )
            .navigationDestination(isPresented: $showingSettings) {
                SettingsScreen(viewModel: viewModel)
            }
            
            switch viewModel.state {
            case .loading:
                ProgressView()

            case .error:
                ProgressView()

            case .ready:
                Group {
                    if viewModel.items.isEmpty {
                        EmptyShoppingListView()
                    } else {
                        shoppingList
                    }
                }
                .overlay(alignment: .bottomTrailing) {
                    AddNewShoppingItemButton {
                        showingSheet.toggle()
                    }
                    .sheet(isPresented: $showingSheet) {
                        AddNewShoppingItemView(addItemFct: viewModel.addItem)
                            .presentationDetents([.large])
                            .presentationDragIndicator(.visible)
                            .presentationBackground(.green.opacity((0.1)))
                    }
                }
            }
        }
        .background(Color.green.opacity(0.1).ignoresSafeArea())
        .task { await viewModel.load(context: modelContext) }
    }
        
}

#Preview {
    ShoppingListScreen()
        .modelContainer(for: ShoppingItem.self)
}
