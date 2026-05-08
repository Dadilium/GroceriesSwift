//
//  ShoppingListViewModel.swift
//  GroceriesSwift
//
//  Created by Antoine ROY on 28/04/2026.
//

import SwiftUI
import SwiftData

enum ShoppingListState: Equatable {
    case loading
    case ready
    case error
}

@Observable
@MainActor
class ShoppingListViewModel {
    var state: ShoppingListState = .loading
    var items: [ShoppingListItem] = []
    
    private var modelContext: ModelContext?
    
    var toBuyItems: [ShoppingListItem] {
        items.filter { !$0.isBought }
    }
    var inBasketItems: [ShoppingListItem] {
        items.filter { $0.isBought }
    }
    
    func addItem(ingredientName: String) {
        guard let modelContext else { return }
        let itemToCreate = ShoppingListItem(ingredient: ingredientName)
        
        modelContext.insert(itemToCreate)
        items.append(itemToCreate)
        items.sort(by: { $0.ingredient.localizedCaseInsensitiveCompare($1.ingredient) == .orderedAscending })
        save()
    }
    
    func setItemAsBought(id: UUID) {
        guard let index = items.firstIndex(where: { $0.id == id }) else { return }
        items[index].isBought.toggle()
        save()
    }

    func deleteItem(id: UUID) {
        guard let modelContext, let item = items.first(where: { $0.id == id }) else { return }
        withAnimation {
            modelContext.delete(item)
            items.removeAll { $0.id == id }
        }
        save()
    }
    
    func load(context: ModelContext) async {
        self.modelContext = context
        let descriptor = FetchDescriptor<ShoppingListItem>(
            sortBy: [SortDescriptor(\.ingredient)]
        )
        
        self.items = (try? context.fetch(descriptor)) ?? []
        state = .ready
    }
    
    private func save() {
        try? modelContext?.save()
    }
}
