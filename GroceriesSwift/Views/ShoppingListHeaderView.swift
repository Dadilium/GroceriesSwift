//
//  ShoppingListHeader.swift
//  GroceriesSwift
//
//  Created by Antoine ROY on 30/04/2026.
//

import SwiftUI

struct ShoppingListHeaderView: View {
    var totalCount: Int
    var boughtCount: Int
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Groceries")
                    .font(.largeTitle.weight(.bold))
                HStack {
                    Text("\(totalCount) items")
                    if totalCount > 0 {
                        Text("·")
                        Text("\(boughtCount) in basket")
                    } else {
                        Spacer()
                    }
                }
                .foregroundStyle(Color(.secondaryLabel))
            }

            Spacer()
            NavigationLink {
                SettingsScreen()
            } label: {
                Image(systemName: "gearshape")
                    .symbolEffect(.bounce.up.wholeSymbol, options: .nonRepeating)
                    .padding(8)
                    .font(.title2)
                    .foregroundStyle(.gray)
                    .background(.white, in: .circle)
                    .shadow(color: .black.opacity(0.1), radius: 5, y: 3)
                    .overlay {
                        Circle().stroke(.gray.opacity(0.2), lineWidth: 1)
                    }
            }
        }
        .padding()
    }
}

#Preview {
    ShoppingListHeaderView(totalCount: 10, boughtCount: 5)
    ShoppingListHeaderView(totalCount: 10, boughtCount: 0)
}
