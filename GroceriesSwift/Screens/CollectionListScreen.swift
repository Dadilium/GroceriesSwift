//
//  CollectionListScreen.swift
//  GroceriesSwift
//
//  Created by Antoine ROY on 17/05/2026.
//

import SwiftUI
import SwiftData

struct CollectionListScreen: View {
    @Environment(\.modelContext) private var modelContext
    
    private var viewModel = CollectionListViewModel()
    
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
        Button(action: { viewModel.createNewCollection(with: "toto")}) {
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
            
            ForEach(viewModel.collections) { item in
                CollectionListItem(collection: item)
            }
            .padding(.horizontal)
            .padding(.vertical, 4)
            
            Spacer()
        }
        .task {
            await viewModel.load(context: modelContext)
        }
    }
}

#Preview {
    CollectionListScreen()
}
