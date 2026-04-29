//
//  ShoppingListView.swift
//  GroceriesSwift
//
//  Created by Antoine ROY on 28/04/2026.
//

import SwiftUI

struct ShoppingListView: View {
    @State private var viewModel = ShoppingListViewModel()
    
    
    private var header: some View {
        HStack {
            Text("Groceries")
                .font(.largeTitle.weight(.bold))
            Spacer()
            Button {
                
            } label: {
                Image(systemName: "gear")
                    .padding(8)
                    .font(.title)
                    .foregroundStyle(.gray)
                    .background(.white, in: .circle)
                    .shadow(color: .black.opacity(0.1), radius: 5, y: 3)
            }
        }
        .padding()
    }
    
    private var ingredientsList: some View {
        List {
            ForEach(viewModel.items, id: \.id) { item in
                Text(item.ingredient.name)
            }
        }
    }
    
    var body: some View {
        VStack {
            header
            
            if viewModel.state == .loading {
                ProgressView()
            }
            
            if viewModel.state == .ready {
                Group {
                    if viewModel.items.isEmpty {
                        EmptyShoppingListView()
                    } else {
                        ingredientsList
                    }
                }
                .overlay(alignment: .bottomTrailing) {
                    Button {
                        
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
                }
            }
        }
        .background(Color.green.opacity(0.1))
        .toolbar {

        }
        .task { await viewModel.load() }
    }
        
}

#Preview {
    NavigationStack {
        ShoppingListView()
    }
}
