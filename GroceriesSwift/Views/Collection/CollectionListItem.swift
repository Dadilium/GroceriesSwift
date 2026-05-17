//
//  CollectionListItem.swift
//  GroceriesSwift
//
//  Created by Antoine ROY on 17/05/2026.
//

import SwiftUI

struct CollectionListItem: View {
    private var itemCount = 5
    private var items: [ShoppingListItem] = [
        ShoppingListItem(ingredient: "Milk", isBought: false),
        ShoppingListItem(ingredient: "Tomatoes", isBought: false),
        ShoppingListItem(ingredient: "eggs", isBought: false),
        ShoppingListItem(ingredient: "funny", isBought: false),
        ShoppingListItem(ingredient: "caramel", isBought: false),
    ]
    
    func itemTag(item: ShoppingListItem) -> some View {
        Text(item.ingredient)
            .font(.footnote)
            .foregroundStyle(.green)
            .padding(8)
            .background(.green.opacity(0.1))
            .cornerRadius(10)
            .overlay() {
                RoundedRectangle(cornerRadius: 10)
                    .stroke()
            }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Title")
                .font(.title2.weight(.semibold))
            
            Text("\(itemCount) items")
            
            HStack {
                ForEach(items, id: \.ingredient) { i in
                    itemTag(item: i)
                }
            }
            
            Text("+ \(itemCount) more")
                .foregroundStyle(.secondary)

        }
        .padding()
        .frame(width: .infinity)
        .background(.white, in: RoundedRectangle(cornerRadius: 16))
        .shadow(radius: 10, y: 3)
    }
}

#Preview {
    CollectionListItem()
}
