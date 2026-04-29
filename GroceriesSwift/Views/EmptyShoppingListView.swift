//
//  EmptyShoppingListView.swift
//  GroceriesSwift
//
//  Created by Antoine ROY on 29/04/2026.
//

import SwiftUI

struct EmptyShoppingListView: View {
    
    var body: some View {
        VStack {
            Spacer()
            Image("basket")
                .frame(width: 100, height: 100)
                .background {
                    ZStack {
                        Circle()
                            .foregroundStyle(.green.opacity(0.5))
                            .frame(width: 250, height: 250)
                            .blur(radius: 40)
                            .offset(x: -50, y: -100)
                        Circle()
                            .foregroundStyle(.orange.opacity(0.5))
                            .frame(width: 250, height: 250)
                            .blur(radius: 40)
                            .offset(x: 50, y: 40)
                    }
                }
            Spacer()
            Text("Your list is empty")
                .font(.title2.bold())
            Text("Tap the green plus to add what you need to buy.")
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                
            Spacer()
        }
    }
}

#Preview {
    EmptyShoppingListView()
}
