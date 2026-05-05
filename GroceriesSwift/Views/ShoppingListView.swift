//
//  ShoppingListView.swift
//  GroceriesSwift
//
//  Created by Antoine ROY on 05/05/2026.
//

import SwiftUI

struct ShoppingListView: View {
    var toBuyItems: [ShoppingListItem]
    var inBasketItems: [ShoppingListItem]
    var setItemAsBought: (UUID) -> Void
    
    var body: some View {
        List {
            if toBuyItems.count > 0 {
                Section {
                    ForEach(toBuyItems) { item in
                        ShoppingListItemRowView(item: item, onItemPressed: setItemAsBought)
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                    }
                } header: {
                    Text("To Buy")
                }
            }
            
            if inBasketItems.count > 0 {
                Section {
                    ForEach(inBasketItems) { item in
                        ShoppingListItemRowView(item: item, onItemPressed: setItemAsBought)
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                    }
                } header: {
                    Text("In basket")
                }
            }
            
            
        }
        .listRowSpacing(-15)
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background(.clear)
        .scrollIndicators(.hidden)
    }
}

#Preview {
    ShoppingListView(toBuyItems: [], inBasketItems: [], setItemAsBought: {_ in })
}
