//
//  CollectionListViewModel.swift
//  GroceriesSwift
//
//  Created by Antoine ROY on 18/05/2026.
//

import SwiftUI
import SwiftData

enum CollectionListState {
    case loading
    case ready
}

@Observable
@MainActor
class CollectionListViewModel {
    var state: CollectionListState = .loading
    var collections: [CollectionItem] = []
    
    private var modelContext: ModelContext?
    
    
    func createNewCollection(with title: String) {
        let collection = CollectionItem(title: title, shoppingItems: [])
        
        collections.append(collection)
        save()
    }
    
    func load(context: ModelContext) async {
        self.modelContext = context
        
        let fetchDescriptor = FetchDescriptor<CollectionItem>(sortBy: [SortDescriptor(\.createdAt)])
        self.collections = (try? context.fetch(fetchDescriptor)) ?? []

        self.state = .ready
    }
    
    func save() {
        try? self.modelContext?.save()
    }
}
