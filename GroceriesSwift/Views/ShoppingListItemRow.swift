//
//  ShoppingListItemRow.swift
//  GroceriesSwift
//
//  Created by Antoine ROY on 30/04/2026.
//

import SwiftUI

struct ShoppingListItemRow: View {
    var item: ShoppingListItem
    
    var body: some View {
        HStack {
            Button {} label: {
                Circle()
                    .stroke(.green, lineWidth: 3)
                    .frame(width: 40, height: 40)
            }
            .padding(4)
            
            Text(item.ingredient.name)
                .foregroundStyle(.primary)
                .font(.title2.weight(.medium))
            Spacer()
        }
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .overlay {
            RoundedRectangle(cornerRadius: 30)
                .stroke(.gray, lineWidth: 1)
        }
    }
}

#Preview {
    Group {
        ShoppingListItemRow(item: ShoppingListItem(ingredient: Ingredient(name: "mon cucumber"), isBought: false))
        ShoppingListItemRow(item: ShoppingListItem(ingredient: Ingredient(name: "My tomate"), isBought: false))
    }

}
