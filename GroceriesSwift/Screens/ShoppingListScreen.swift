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

    private var addNewItemButton: some View {
        Button {
            showingSheet.toggle()
        } label: {
            Image(systemName: "plus")
                .padding()
                .frame(width: 80, height: 80)
                .font(.largeTitle.weight(.semibold))
                .foregroundStyle(.white)
                .background(.green, in: .circle)
                .shadow(color: .black.opacity(0.1), radius: 5, y: 3)
        }
        .accessibilityLabel("Add item")
        .padding(.trailing ,32)
        .padding(.bottom, 16)
        .sheet(isPresented: $showingSheet) {
            AddNewShoppingItemView(addItemFct: viewModel.addItem)
                .presentationDetents([.large])
                .presentationDragIndicator(.visible)
                .presentationBackground(.green.opacity((0.1)))
        }
    }
    
    private var shoppingList: some View {
        List {
            if viewModel.toBuyItems.count > 0 {
                ShoppingListSection(items: viewModel.toBuyItems, setItemAsBought: viewModel.setItemAsBought, deleteItem: viewModel.deleteItem) {
                    ShoppingListSectionHeader(dotColor: .green, title: "To Buy", count: viewModel.toBuyItems.count)
                }
            }
            
            if viewModel.inBasketItems.count > 0 {
                ShoppingListSection(items: viewModel.inBasketItems, setItemAsBought: viewModel.setItemAsBought, deleteItem: viewModel.deleteItem) {
                    ShoppingListSectionHeader(dotColor: .green.opacity(0.5), title: "In Basket", count: viewModel.inBasketItems.count)
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
                    addNewItemButton
                }
            }
        }
        .background(Color.green.opacity(0.1).ignoresSafeArea())
        .task { await viewModel.load(context: modelContext) }
    }
        
}

#Preview {
    NavigationStack {
        ShoppingListScreen()
            .modelContainer(for: ShoppingListItem.self)
    }
}
