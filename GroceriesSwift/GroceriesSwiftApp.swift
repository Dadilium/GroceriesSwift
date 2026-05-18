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
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [ShoppingItem.self, CollectionItem.self])
    }
}
