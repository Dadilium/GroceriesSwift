//
//  ShoppingListSection.swift
//  GroceriesSwift
//
//  Created by Antoine ROY on 06/05/2026.
//

import SwiftUI


struct ShoppingListSection<Header: View>: View {
    var items: [ShoppingListItem]
    var setItemAsBought: (UUID) -> Void
    var deleteItem: (UUID) -> Void
    var header: Header

    init(items: [ShoppingListItem], setItemAsBought: @escaping (UUID) -> Void, deleteItem: @escaping (UUID) -> Void, @ViewBuilder header: () -> Header) {
        self.items = items
        self.setItemAsBought = setItemAsBought
        self.deleteItem = deleteItem
        self.header = header()
    }

    var body: some View {
        Section {
            ForEach(items) { item in
                ShoppingListItemRowView(item: item, onItemPressed: setItemAsBought, onItemDeleted: deleteItem)
                    .transition(.opacity)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
            }
        } header: {
            header
        }
    }
}
