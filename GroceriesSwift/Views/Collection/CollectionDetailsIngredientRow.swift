//
//  CollectionDetailsIngredientRow.swift
//  GroceriesSwift
//
//  Created by Antoine ROY on 28/05/2026.
//

import SwiftUI

struct CollectionDetailsIngredientRow: View {
    var title: String
    var onPress: () -> Void

    @State private var isAdded: Bool = false

    init(title: String, onPress: @escaping () -> Void) {
        self.title = title
        self.onPress = onPress
    }
    
    var body: some View {
        HStack {
            Button {
                onPress()
                isAdded = true
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
