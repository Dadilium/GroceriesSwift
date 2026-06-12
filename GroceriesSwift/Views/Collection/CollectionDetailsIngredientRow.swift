//
//  CollectionDetailsIngredientRow.swift
//  GroceriesSwift
//
//  Created by Antoine ROY on 28/05/2026.
//

import SwiftUI

struct CollectionDetailsIngredientRow: View {
    var title: String
    var isAdded: Bool
    var onPress: () -> Void

    init(title: String, isAdded: Bool, onPress: @escaping () -> Void) {
        self.title = title
        self.isAdded = isAdded
        self.onPress = onPress
    }
    
    var body: some View {
        HStack {
            Button {
                onPress()
            } label: {
                Image(systemName: isAdded ? "checkmark" : "plus")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .padding(10)
                    .background(.green.opacity(0.3), in: RoundedRectangle(cornerRadius: 5))
                    .foregroundStyle(.green)
            }
            
            Text(title)
            Spacer()
        }
        .padding()
        .overlay() {
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray, lineWidth: 0.2)
        }
        .background(.white, in: RoundedRectangle(cornerRadius: 16))
        .shadow(radius: 10, y: 3)
    }
}
