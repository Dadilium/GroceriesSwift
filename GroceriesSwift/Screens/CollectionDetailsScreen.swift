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
    
    func ingredientItem(title: String) -> some View {
        HStack {
            Image(systemName: "plus")
                .resizable()
                .frame(width: 20, height: 20)
                .padding(10)
                .background(.green.opacity(0.3), in: RoundedRectangle(cornerRadius: 5))
                .foregroundStyle(.green)
            
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
    
    var body: some View {
        VStack {
            VStack {
                header
                addAllItemsToList
                    .padding(.top)
            }
            .padding(.horizontal)
            .padding(.top)
            
            List {
                Section {
                    ForEach(collection?.shoppingItems ?? [ShoppingItem(ingredient: "my shoppin32g item"), ShoppingItem(ingredient: "my shoppin32g item")]) { item in
                        
                        ingredientItem(title: item.ingredient)
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                    }
                } header: {
                    ShoppingListSectionHeader(dotColor: .clear, title: "Items", subTitle: "Swipe left to remove")
                        .padding(.leading, -16)
                }
            }
            .listRowSpacing(-16)
            .listStyle(.plain)
            .scrollIndicators(.hidden)
            
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
