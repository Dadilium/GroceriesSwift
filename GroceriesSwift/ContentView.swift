//
//  ContentView.swift
//  GroceriesSwift
//
//  Created by Antoine ROY on 17/05/2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            TabView {
                ShoppingListScreen()
                    .tabItem {
                        Label("Shopping", systemImage: "cart")
                    }
                
                CollectionListScreen()
                    .tabItem {
                        Label("Collections", systemImage: "menucard")
                    }
            }
        }
    }
}

#Preview {
    NavigationView {
        ContentView()
    }
}
