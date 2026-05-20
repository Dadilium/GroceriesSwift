//
//  CollectionItem.swift
//  GroceriesSwift
//
//  Created by Antoine ROY on 18/05/2026.
//

import SwiftData
import Foundation

@Model
class CollectionItem {
    var id: UUID
    var title: String
    var shoppingItems: [ShoppingItem]
    var createdAt: Date?
    
    var topOfTheList: [ShoppingItem] {
        let end = min(4, shoppingItems.count)
        return Array(shoppingItems.prefix(end))
    }
    
    func rename(to newTitle: String) {
        title = newTitle
    }
    
    init(title: String, shoppingItems: [ShoppingItem], createdAt: Date? = nil) {
        self.id = UUID()
        self.title = title
        self.shoppingItems = shoppingItems
        self.createdAt = createdAt ?? Date()
    }
}
