//
//  GroceriesSwiftApp.swift
//  GroceriesSwift
//
//  Created by Antoine ROY on 27/04/2026.
//

import SwiftUI
import SwiftData

@main
struct GroceriesSwiftApp: App {
    let container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(for: GroceryList.self, CollectionItem.self)
            
            let context = ModelContext(container)
            let existing = try context.fetch(FetchDescriptor<GroceryList>())
            
            if existing.isEmpty {
                context.insert(GroceryList())
                try context.save()
            }
        } catch {
            fatalError("Failed to set up data store: \(error)")
        }
    }
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container)
    }
}
