//
//  ShoppingListView.swift
//  GroceriesSwift
//
//  Created by Antoine ROY on 28/04/2026.
//

import SwiftUI

struct ShoppingListScreen: View {
    @State private var viewModel = ShoppingListViewModel()
    @State private var showingSheet = false
    
    var body: some View {
        VStack {
            ShoppingListHeaderView(totalCount: viewModel.items.count, boughtCount: viewModel.inBasketItems.count)
            
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
                        ShoppingListView(toBuyItems: viewModel.toBuyItems, inBasketItems: viewModel.inBasketItems, setItemAsBought: viewModel.setItemAsBought)
                    }
                }
                .overlay(alignment: .bottomTrailing) {
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
                            .presentationDetents([.medium])
                    }
                }
            }
        }
        .background(Color.green.opacity(0.1).ignoresSafeArea())
        .task { await viewModel.load() }
    }
        
}

#Preview {
    NavigationStack {
        ShoppingListScreen()
    }
}
