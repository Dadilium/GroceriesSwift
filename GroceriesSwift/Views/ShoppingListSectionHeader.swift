//
//  ShoppingListSectionHeader.swift
//  GroceriesSwift
//
//  Created by Antoine ROY on 06/05/2026.
//

import SwiftUI

struct ShoppingListSectionHeader: View {
    var dotColor: Color
    var title: String
    var count: Int
    
    var body: some View {
        HStack {
            Circle()
                .fill(dotColor)
                .frame(width: 10, height: 10)
            Text("\(title) · \(count)")
            Spacer()
        }
        .foregroundStyle(.secondary)
    }
}

#Preview {
    ShoppingListSectionHeader(dotColor: .green, title: "To Buy", count: 10)
    ShoppingListSectionHeader(dotColor: .green.opacity(0.5), title: "In Basket", count: 10)
}
