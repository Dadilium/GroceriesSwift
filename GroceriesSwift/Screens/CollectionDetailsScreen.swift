//
//  CollectionDetailsScreen.swift
//  GroceriesSwift
//
//  Created by Antoine ROY on 20/05/2026.
//

import SwiftUI
import SwiftData

struct CollectionDetailsScreen: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    var collectionId: UUID
    
    @State private var viewModel = CollectionDetailsViewModel()
    @Query private var allCollections: [CollectionItem]
    
    init(collectionId: UUID) {
        self.collectionId = collectionId
        _allCollections = Query()
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
            viewModel.addAllItemToShoppingList(context: modelContext, collection: collection)
        } label: {
            HStack {
                Image(systemName: "plus")
                Text("Add all items to my list")
            }
            .foregroundStyle(.white)
            .font(.title2)
            .padding()
            .frame(maxWidth: .infinity)
            .background(.green, in: RoundedRectangle(cornerRadius: 16))
        }
    }
    
    var emptyItemList: some View {
        VStack(alignment: .center) {
            Spacer()
            Text("Add shopping items to your list")
            Spacer()
        }
    }
    
    var populatedItemList: some View {
        List {
            Section {
                ForEach(collection?.shoppingItems ?? []) { item in
                    let alreadyAdded = viewModel.currentShoppingList?.items
                        .contains(where: { $0.ingredient == item.ingredient }) ?? false
                    
                    CollectionDetailsIngredientRow(title: item.ingredient, isAdded: alreadyAdded) {
                        viewModel.addItemToShoppingList(context: modelContext, newShoppingItem: item)
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    .swipeActions() {
                        Button(role: .destructive) {
                            viewModel.deleteItem(context: modelContext, collection: collection, id: item.id)
                        } label: {
                            Image(systemName: "xmark.bin.fill")
                                .symbolEffect(.drawOn)
                        }
                    }
                }
            } header: {
                ShoppingListSectionHeader(dotColor: .clear, title: "Items", subTitle: "Swipe left to remove")
                    .padding(.leading, -16)
            }
        }
        
    }
        
    var body: some View {
        VStack {
            VStack {
                header
                
                if collection?.shoppingItems.count ?? 0 > 0 {
                    addAllItemsToList
                        .padding(.top)
                }
            }
            .padding(.horizontal)
            .padding(.top)
            
            
            if collection?.shoppingItems.count ?? 0 > 0 {
                populatedItemList
                    .listRowSpacing(-16)
                    .listStyle(.plain)
                    .scrollIndicators(.hidden)
            } else {
                emptyItemList
            }
            Spacer()
            
        }
        .background(.green.opacity(0.1))
        .overlay(alignment: .bottomTrailing) {
            AddNewShoppingItemButton {
                viewModel.showingSheet.toggle()
            }
            .sheet(isPresented: $viewModel.showingSheet) {
                AddNewShoppingItemView(addItemFct: { ingredient in viewModel.addItemToCollection(context: modelContext, collection: collection, newIngredient: ingredient) })
                    .presentationDetents([.large])
                    .presentationDragIndicator(.visible)
                    .presentationBackground(.green.opacity((0.1)))
            }
        }
        .task {
            await viewModel.load(context: modelContext)
        }
    }
    
}


#Preview {
    let c = CollectionItem(title: "test", shoppingItems: [
        ShoppingItem(ingredient: "my shopping item")
    ])
    CollectionDetailsScreen(collectionId: c.id)
}
