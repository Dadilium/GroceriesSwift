//
//  GroceriesSwiftApp.swift
//  GroceriesSwift
//
//  Created by Antoine ROY on 27/04/2026.
//

import SwiftUI

@main
struct GroceriesSwiftApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ShoppingListView()
            }
        }
    }
}
