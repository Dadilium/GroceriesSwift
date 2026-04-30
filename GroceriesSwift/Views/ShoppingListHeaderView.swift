//
//  ShoppingListHeader.swift
//  GroceriesSwift
//
//  Created by Antoine ROY on 30/04/2026.
//

import SwiftUI

struct ShoppingListHeaderView: View {
    
    var body: some View {
        HStack {
            Text("Groceries")
                .font(.largeTitle.weight(.bold))
            Spacer()
            Button {
                
            } label: {
                Image(systemName: "gear")
                    .padding(8)
                    .font(.title)
                    .foregroundStyle(.gray)
                    .background(.white, in: .circle)
                    .shadow(color: .black.opacity(0.1), radius: 5, y: 3)
            }
        }
        .padding()
    }
}
