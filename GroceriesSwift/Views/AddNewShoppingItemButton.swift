//
//  AddNewShoppingItemButton.swift
//  GroceriesSwift
//
//  Created by Antoine ROY on 22/05/2026.
//

import SwiftUI

struct AddNewShoppingItemButton: View {
    var action: () -> Void
    
    init(action: @escaping () -> Void) {
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: "plus")
                .resizable()
                .padding()
                .frame(width: 70, height: 70)
                .foregroundStyle(.white)
                .background(.green, in: .circle)
                .shadow(color: .black.opacity(0.1), radius: 5, y: 3)
        }
        .accessibilityLabel("Add item")
        .padding(.bottom, 16)
        .padding(.trailing)
    }
}
