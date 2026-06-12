//
//  SettingsViewModel.swift
//  GroceriesSwift
//
//  Created by Antoine ROY on 12/06/2026.
//

import SwiftData
import Foundation

enum SettingsScreenState: Equatable {
    case loading
    case error
    case ready(GroceryList)
}

@Observable
@MainActor
class SettingsViewModel {
    var state: SettingsScreenState = .loading
    
    var itemCount: Int {
        guard case .ready(let list) = state else { return 0 }
        return list.items.count
    }

    var inBasketItems: [ShoppingItem] {
        guard case .ready(let list) = state else { return [] }
        return list.items.filter { $0.isBought }
    }
    
    func clearAll(context: ModelContext) {
        guard case .ready(let list) = state else { return }

        list.items.removeAll()
        try? context.save()
    }
    
    func load(context: ModelContext) async {
        do {
            let descriptor = FetchDescriptor<GroceryList>()
            guard let shoppingList = try context.fetch(descriptor).first else {
                state = .error
                return
            }
            
            state = .ready(shoppingList)
        } catch {
            // In case of fetch failure, keep the current list unchanged
            #if DEBUG
            print("Failed to fetch shopping items: \(error)")
            #endif
            state = .error
        }
    }
}
