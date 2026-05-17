//
//  CollectionListScreen.swift
//  GroceriesSwift
//
//  Created by Antoine ROY on 17/05/2026.
//

import SwiftUI

struct CollectionListScreen: View {
    
    var header: some View {
        HStack {
            VStack {
                Text("Collections")
                    .font(Font.largeTitle.bold())
                
                Text("Your saved grocery lists")
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
        .padding()
    }
    
    var newCollectionButton: some View {
        Button(action: {}) {
            HStack {
                Image(systemName: "plus")
                Text("New Collection")
            }
            .foregroundStyle(.gray)
            .frame(maxWidth: .infinity)
            .padding(32)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .strokeBorder(
                        style: StrokeStyle(lineWidth: 2, dash: [8, 4])
                    )
                    .foregroundStyle(.gray.opacity(0.5))
            )
        }
        .padding(.horizontal)
    }
    
    var body: some View {
        VStack {
            header
            newCollectionButton
            Spacer()
        }
    }
}

#Preview {
    CollectionListScreen()
}
