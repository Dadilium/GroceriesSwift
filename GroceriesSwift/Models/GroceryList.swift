//
//  GroceryList.swift
//  GroceriesSwift
//
//  Created by Antoine ROY on 26/05/2026.
//

import SwiftData

@Model
class GroceryList {
    var items: [ShoppingItem]
    
    init() {
        self.items = []
    }
}
