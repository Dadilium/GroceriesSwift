//
//  ShoppingListViewModel.swift
//  GroceriesSwift
//
//  Created by Antoine ROY on 28/04/2026.
//

import SwiftUI

struct Ingredient: Equatable {
    var name: String
}

struct ShoppingListItem: Equatable, Identifiable {
    var id: UUID = UUID()
    var ingredient: Ingredient
    var isBought: Bool
}

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
    
    var toBuyItems: [ShoppingListItem] {
        items.filter({ !$0.isBought })
    }
    var inBasketItems: [ShoppingListItem] {
        items.filter({ $0.isBought })
    }
    
    func addItem(ingredientName: String) {
        items.append(ShoppingListItem(ingredient: Ingredient(name: ingredientName), isBought: false))
        items.sort(by: { $0.ingredient.name.localizedCaseInsensitiveCompare($1.ingredient.name) == .orderedAscending })
    }
    
    func setItemAsBought(id: UUID) {
        withAnimation {
            if let index = items.firstIndex(where: { $0.id == id }) {
                items[index].isBought.toggle()
            }
        }
    }
    
    func load() async {
        do {
            try await Task.sleep(nanoseconds: 1000)
            // load data from cache
            state = .ready
            
            items = [
                ShoppingListItem(ingredient: Ingredient(name: "Tomates"), isBought: true),
                ShoppingListItem(ingredient: Ingredient(name: "Laitue"), isBought: false),
                ShoppingListItem(ingredient: Ingredient(name: "Pommes"), isBought: false),
            ]
        } catch {
            state = .error
        }
    }
}
