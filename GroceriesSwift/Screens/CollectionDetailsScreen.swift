//
//  CollectionDetailsScreen.swift
//  GroceriesSwift
//
//  Created by Antoine ROY on 20/05/2026.
//

import SwiftUI
import SwiftData

struct CollectionDetailsScreen: View {
    @Environment(\.dismiss) private var dismiss
    var collectionId: UUID
    
    @Query private var allCollections: [CollectionItem]
    
    init(collectionId: UUID) {
        print(collectionId)
        self.collectionId = collectionId
        _allCollections = Query()
        print(_allCollections)
    }
    
    private var collection: CollectionItem? {
        return allCollections.first { $0.id == collectionId }
    }
    
    var header: some View {
        VStack(alignment: .leading) {
            TextField("", text: Binding(
                get: { collection?.title ?? "Error"},
                set: { collection?.title = $0 }
            ))
            .foregroundStyle(.primary)
            .font(.title.bold())
            .onReceive(NotificationCenter.default.publisher(
                    for: UITextField.textDidBeginEditingNotification
                )) { obj in
                    if let textField = obj.object as? UITextField {
                        textField.selectAll(nil)
                    }
                }
            
            Text("\(collection?.shoppingItems.count ?? 0) items")
                .foregroundStyle(.secondary)
        }
    }
    
    var addAllItemsToList: some View {
        Button {
            
        } label: {
            HStack {
                Image(systemName: "plus")
            }
            .background(.green)
        }
    }
    
    var body: some View {
        VStack {
            header
            addAllItemsToList
            Spacer()
        }
        .padding()
        
    }
    
}

//#Preview {
//    CollectionDetailsScreen(collectionId: UUID(from: 0 as! Decoder))
//}
