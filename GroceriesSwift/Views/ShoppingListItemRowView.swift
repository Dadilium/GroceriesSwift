//
//  ShoppingListItemRowView.swift
//  GroceriesSwift
//
//  Created by Antoine ROY on 30/04/2026.
//

import SwiftUI

struct ShoppingListItemRowView: View {
    var item: ShoppingListItem
    var onItemPressed: (UUID) -> Void

    var body: some View {
        HStack {
            Button {
                onItemPressed(item.id)
            } label: {
                Circle()
                    .stroke(.green, lineWidth: 3)
                    .frame(width: 40, height: 40)
                    .background(item.isBought ? .green : .clear)
                    .clipShape(.circle)
                    .overlay {
                        if item.isBought {
                            Image(systemName: "checkmark")
                                .foregroundStyle(.white)
                                .font(.title3.bold())
                        }
                    }
            }
            .padding(4)
            
            Text(item.ingredient.name)
                .foregroundStyle(item.isBought ? .gray : .primary)
                .font(.title2.weight(.medium))
                .strikethrough(item.isBought)
            
            Spacer()
        }
        .padding()
        .background(item.isBought ? .brown.opacity(0.2) : .white)
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .overlay {
            RoundedRectangle(cornerRadius: 30)
                .stroke(.gray, lineWidth: 1)
        }
        
    }
}

#Preview {
    Group {
        ShoppingListItemRowView(item: ShoppingListItem(ingredient: Ingredient(name: "mon cucumber"), isBought: false), onItemPressed: { _ in })
        ShoppingListItemRowView(item: ShoppingListItem(ingredient: Ingredient(name: "My tomate"), isBought: true), onItemPressed: { _ in })
    }

}
