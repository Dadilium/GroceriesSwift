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
    
    func load() async {
        do {
            try await Task.sleep(nanoseconds: 1000)
            // load data from cache
            state = .ready
            
//            items = [
//                ShoppingListItem(ingredient: Ingredient(name: "Tomates"), isBought: true),
//                ShoppingListItem(ingredient: Ingredient(name: "Laitue"), isBought: false),
//                ShoppingListItem(ingredient: Ingredient(name: "Pommes"), isBought: false),
//                ShoppingListItem(ingredient: Ingredient(name: "Tomates"), isBought: true),
//                ShoppingListItem(ingredient: Ingredient(name: "Laitue"), isBought: false),
//                ShoppingListItem(ingredient: Ingredient(name: "Pommes"), isBought: false),
//                ShoppingListItem(ingredient: Ingredient(name: "Tomates"), isBought: true),
//                ShoppingListItem(ingredient: Ingredient(name: "Laitue"), isBought: false),
//                ShoppingListItem(ingredient: Ingredient(name: "Pommes"), isBought: false),
//                ShoppingListItem(ingredient: Ingredient(name: "Tomates"), isBought: true),
//                ShoppingListItem(ingredient: Ingredient(name: "Laitue"), isBought: false),
//                ShoppingListItem(ingredient: Ingredient(name: "Pommes"), isBought: false),
//                ShoppingListItem(ingredient: Ingredient(name: "Tomates"), isBought: true),
//                ShoppingListItem(ingredient: Ingredient(name: "Laitue"), isBought: false),
//                ShoppingListItem(ingredient: Ingredient(name: "Pommes"), isBought: false),
//            ]
        } catch {
            state = .error
        }
    }
}
