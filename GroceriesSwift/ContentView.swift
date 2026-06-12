//
//  ContentView.swift
//  GroceriesSwift
//
//  Created by Antoine ROY on 17/05/2026.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Int = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                ShoppingListScreen()
            }
            .tabItem {
                Label("Shopping", systemImage: "cart")
            }
            .tag(0)
            
            NavigationStack {
                CollectionListScreen()
            }
            .tabItem {
                Label("Collections", systemImage: "menucard")
            }
            .tag(1)
            
            NavigationStack {
                SettingsScreen(selectedTab: $selectedTab)
            }
            .tabItem {
                Label("Settings", systemImage: "gearshape")
            }
            .tag(2)
        }
    }
}

#Preview {
    NavigationView {
        ContentView()
    }
}
