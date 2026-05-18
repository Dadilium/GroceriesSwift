//
//  CollectionListItem.swift
//  GroceriesSwift
//
//  Created by Antoine ROY on 17/05/2026.
//

import SwiftUI

struct CollectionListItem: View {
    private var itemCount = 5
    private var items: [ShoppingItem] = [
        ShoppingItem(ingredient: "Milk", isBought: false),
        ShoppingItem(ingredient: "Tomatoes", isBought: false),
        ShoppingItem(ingredient: "eggs", isBought: false),
        ShoppingItem(ingredient: "funny", isBought: false),
        ShoppingItem(ingredient: "caramel", isBought: false),
    ]
    
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
            
            Text("\(itemCount) items")
            
            HStack {
                ForEach(items[0..<5], id: \.ingredient) { i in
                    itemTag(item: i)
                }
                Spacer()
            }
            
            Text("+ \(itemCount) more")
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
    CollectionListItem()
}
