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
    
    var collection: CollectionItem?
    private(set) var currentShoppingList: [ShoppingItem] = []
    
    init(collection: CollectionItem? = nil) {
        self.collection = collection
    }
    
    func addAllItemToShoppingList(context: ModelContext) {
        // Merge items, avoiding duplicates by ingredient

        guard let items = collection?.shoppingItems else { return }
        for item in items {
            let foundItem = currentShoppingList.first { existing in
                existing.ingredient == item.ingredient
            }
            
            if foundItem == nil {
                context.insert(ShoppingItem(ingredient: item.ingredient))
                currentShoppingList.append(item)
            }
        }
        
        save(context: context)
    }
    
    func addItemToCollection(context: ModelContext, newItem: ShoppingItem) {
        if collection?.shoppingItems.contains(where: { $0.ingredient == newItem.ingredient }) == true { return }

        collection?.shoppingItems.append(newItem)
        save(context: context)
    }
    
    func updateCollectionName(context: ModelContext, newName: String) {
        collection?.title = newName
        save(context: context)
    }
 
    func load(context: ModelContext) async {
        do {
            let descriptor = FetchDescriptor<ShoppingItem>(sortBy: [SortDescriptor(\ShoppingItem.ingredient)])
            currentShoppingList = try context.fetch(descriptor)
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
