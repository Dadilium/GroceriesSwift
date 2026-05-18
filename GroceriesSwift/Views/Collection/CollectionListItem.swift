//
//  CollectionListItem.swift
//  GroceriesSwift
//
//  Created by Antoine ROY on 17/05/2026.
//

import SwiftUI

struct CollectionListItem: View {
    var collection: CollectionItem
    
    func itemTag(item: ShoppingItem) -> some View {
        Text(item.ingredient.capitalized)
            .font(.footnote)
            .foregroundStyle(.green)
            .padding(8)
            .background(.green.opacity(0.1))
            .cornerRadius(10)
            .overlay() {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.gray.opacity(0.2))
            }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Title")
                .font(.title2.weight(.semibold))
            
            Text("\(collection.shoppingItems.count) items")
            
            HStack {
                ForEach(collection.shoppingItems[0..<4], id: \.ingredient) { i in
                    itemTag(item: i)
                }
                Spacer()
            }
            
            Text("+ \(collection.shoppingItems.count) more")
                .foregroundStyle(.secondary)
        }
        .padding()
        .padding(.vertical)
        .frame(width: .infinity)
        .background(.white, in: RoundedRectangle(cornerRadius: 16))
        .overlay(alignment: .topTrailing) {
            Image(systemName: "chevron.right")
                .resizable()
                .frame(width: 10, height: 15)
                .foregroundStyle(.gray)
                .padding(40)
                .background(.red.opacity(0.2), in: Circle())
                .padding(.trailing, -16)
                .padding(.top, -16)
        }
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(radius: 10, y: 3)
    }
}

#Preview {
    CollectionListItem(collection: CollectionItem(title: "Super List", shoppingItems: [
        ShoppingItem(ingredient: "Milk"),
        ShoppingItem(ingredient: "Tomatoes"),
        ShoppingItem(ingredient: "butter"),
        ShoppingItem(ingredient: "Dragon fruit"),
    ]))
}
