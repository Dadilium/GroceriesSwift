//
//  CollectionDetailsViewModel.swift
//  GroceriesSwift
//
//  Created by Antoine ROY on 25/05/2026.
//

import SwiftData
import SwiftUI

@Observable
@MainActor
class CollectionDetailsViewModel {
    var showingSheet = false
    
    private(set) var currentShoppingList: GroceryList?
    
    private func addItemToShoppingListIfNew(list: [ShoppingItem], newItem: ShoppingItem) {
        let foundItem = list.first { existing in
            existing.ingredient == newItem.ingredient
        }
        
        if foundItem == nil {
            currentShoppingList?.items.append(newItem)
        }
    }
    
    func addAllItemToShoppingList(context: ModelContext, collection: CollectionItem?) {
        // Merge items, avoiding duplicates by ingredient
        guard let items = collection?.shoppingItems, let listItems = currentShoppingList?.items else { return }
        
        for item in items {
            addItemToShoppingListIfNew(list: listItems, newItem: item)
        }
        
        save(context: context)
    }
    
    func addItemToShoppingList(context: ModelContext, newShoppingItem: ShoppingItem) {
        guard let listItems = currentShoppingList?.items else { return }
        
        addItemToShoppingListIfNew(list: listItems, newItem: newShoppingItem)
        save(context: context)
    }
    
    func addItemToCollection(context: ModelContext, collection: CollectionItem?, newIngredient: String) {
        guard let collection else { return }
        if collection.shoppingItems.contains(where: { $0.ingredient == newIngredient }) == true { return }

        collection.shoppingItems.append(ShoppingItem(ingredient: newIngredient))
        save(context: context)
    }
    
    func deleteItem(context: ModelContext, collection: CollectionItem?, id: UUID) {
        guard let collection else { return }

        withAnimation {
            collection.shoppingItems.removeAll { $0.id == id }
        }
        try? context.save()
    }
 
    func load(context: ModelContext) async {
        do {
            let descriptor = FetchDescriptor<GroceryList>()
            currentShoppingList = try context.fetch(descriptor).first
        } catch {
            // In case of fetch failure, keep the current list unchanged
            #if DEBUG
            print("Failed to fetch shopping items: \(error)")
            #endif
        }
    }
    
    func save(context: ModelContext) {
        try? context.save()
    }
}
