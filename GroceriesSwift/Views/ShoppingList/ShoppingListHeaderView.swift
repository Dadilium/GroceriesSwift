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
        }
        .padding()
    }
}

#Preview {
    ShoppingListHeaderView(totalCount: 10, boughtCount: 5)
    ShoppingListHeaderView(totalCount: 10, boughtCount: 0)
}
