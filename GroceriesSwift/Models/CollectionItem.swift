//
//  CollectionItem.swift
//  GroceriesSwift
//
//  Created by Antoine ROY on 18/05/2026.
//

import SwiftData
import SwiftUI

@Model
class CollectionItem {
    var id: UUID
    var title: String
    var shoppingItems: [ShoppingItem]
    var createdAt: Date?
    var colorName: String = "default"

    private static let palette = ["red", "orange", "yellow", "green", "teal", "blue", "purple", "pink"]

    var color: Color {
        switch colorName {
        case "red":    return .red
        case "orange": return .orange
        case "yellow": return .yellow
        case "green":  return .green
        case "teal":   return .teal
        case "blue":   return .blue
        case "purple": return .purple
        case "pink":   return .pink
        default:       return .gray
        }
    }
    
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
        self.colorName = CollectionItem.palette.randomElement()!
    }
}
