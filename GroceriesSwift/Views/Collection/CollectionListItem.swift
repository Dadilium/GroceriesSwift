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
            Text(collection.title)
                .font(.title2.weight(.semibold))
            
            Text("\(collection.shoppingItems.count) items")
            
            HStack {
                ForEach(collection.topOfTheList, id: \.ingredient) { i in
                    itemTag(item: i)
                }
                Spacer()
            }
            
            if collection.shoppingItems.count > collection.topOfTheList.count {
                Text("+\(collection.shoppingItems.count - collection.topOfTheList.count) more")
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .padding(.vertical)
        .frame(maxWidth: .infinity)
        .background(.white, in: RoundedRectangle(cornerRadius: 16))
        .overlay(alignment: .topTrailing) {
            Image(systemName: "chevron.right")
                .resizable()
                .frame(width: 10, height: 15)
                .foregroundStyle(.gray)
                .padding(40)
                .background(collection.color.opacity(0.2), in: Circle())
                .padding(.trailing, -16)
                .padding(.top, -16)
        }
        .shadow(radius: 10, y: 3)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    CollectionListItem(collection: CollectionItem(title: "Super List", shoppingItems: [
        ShoppingItem(ingredient: "Milk"),
        ShoppingItem(ingredient: "Tomatoes"),
        ShoppingItem(ingredient: "butter"),
        ShoppingItem(ingredient: "Dragon fruit"),
        ShoppingItem(ingredient: "butter"),
        ShoppingItem(ingredient: "Dragon fruit"),
    ]))
}
