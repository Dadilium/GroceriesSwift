//
//  Ingredient.swift
//  GroceriesSwift
//
//  Created by Antoine ROY on 08/05/2026.
//

import SwiftData
import Foundation

@Model
class ShoppingListItem {
    var id: UUID
    var ingredient: String
    var isBought: Bool
    
    init(ingredient: String, isBought: Bool = false) {
        self.id = UUID()
        self.ingredient = ingredient
        self.isBought = isBought
    }
}
