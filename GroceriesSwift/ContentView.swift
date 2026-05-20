//
//  ContentView.swift
//  GroceriesSwift
//
//  Created by Antoine ROY on 17/05/2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationStack {
                ShoppingListScreen()
            }
            .tabItem {
                Label("Shopping", systemImage: "cart")
            }
            
            NavigationStack {
                CollectionListScreen()
            }
            .tabItem {
                Label("Collections", systemImage: "menucard")
            }
        }
    }
}

#Preview {
    NavigationView {
        ContentView()
    }
}
