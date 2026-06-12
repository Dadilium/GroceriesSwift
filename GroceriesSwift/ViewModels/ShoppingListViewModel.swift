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
    case ready(GroceryList)
    case error
}

@Observable
@MainActor
class ShoppingListViewModel {
    var state: ShoppingListState = .loading
    
    private var modelContext: ModelContext!
    
    var toBuyItems: [ShoppingItem] {
        guard case .ready(let list) = state else { return [] }
        return list.items.filter { !$0.isBought }
    }
    var inBasketItems: [ShoppingItem] {
        guard case .ready(let list) = state else { return [] }
        return list.items.filter { $0.isBought }
    }
    var itemCount: Int {
        guard case .ready(let list) = state else { return 0 }
        return list.items.count
    }
    
    func addItem(ingredientName: String) {
        guard case .ready(let list) = state else { return }

        let itemToCreate = ShoppingItem(ingredient: ingredientName)
        
        list.items.append(itemToCreate)
        list.items.sort(by: { $0.ingredient.localizedCaseInsensitiveCompare($1.ingredient) == .orderedAscending })
        save()
    }
    
    func setItemAsBought(id: UUID) {
        guard case .ready(let list) = state else { return }
        guard let index = list.items.firstIndex(where: { $0.id == id }) else { return }

        list.items[index].isBought.toggle()
        save()
    }

    func deleteItem(id: UUID) {
        guard case .ready(let list) = state else { return }

        withAnimation {
            list.items.removeAll { $0.id == id }
        }
        save()
    }
    
    func load(context: ModelContext) async {
        self.modelContext = context
        
        do {
            guard let result = try context.fetch(FetchDescriptor<GroceryList>()).first else {
                state = .error
                return
            }
            
            state = .ready(result)
        } catch {
            state = .error
        }
    }
    
    private func save() {
        try? modelContext.save()
    }
}
