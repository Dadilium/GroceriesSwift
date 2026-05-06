//
//  AddNewShoppingItemView.swift
//  GroceriesSwift
//
//  Created by Antoine ROY on 01/05/2026.
//

import SwiftUI

struct AddNewShoppingItemView: View {
    var addItemFct: (String) -> Void
    
    @Environment(\.dismiss) private var dismiss
    @State private var itemName: String = ""
    @FocusState private var isNameFocused: Bool
    
    private var inputCard: some View {
        VStack(alignment: .leading, spacing: 32) {
            Text("What do you need?")
                .font(.title3.weight(.semibold))
                .foregroundStyle(.gray)
            
            TextField("Item name", text: $itemName)
                .autocorrectionDisabled()
                .focused($isNameFocused)
                .submitLabel(.done)
                .onSubmit {
                    addItemFct(itemName)
                    dismiss()
                }
        }
        .padding(24)
        .background(.white, in: RoundedRectangle(cornerRadius: 20))
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(.green.opacity(0.8), lineWidth: 3)
        }
        .padding(3)
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(.green.opacity(0.3), lineWidth: 10)
        }
    }
    
    private var addButton: some View {
        Button("Add") {
            print("added")
            addItemFct(itemName)
            dismiss()
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(.green, in: RoundedRectangle(cornerRadius: 16))
        .contentShape(RoundedRectangle(cornerRadius: 16))
        .foregroundStyle(.white)
        .font(.headline)
        .disabled(itemName.isEmpty)
        .padding(.top)
        .shadow(radius: 10, y: 3)
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Add Item")
                    .font(.title.weight(.semibold))
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                        .font(.title3)
                        .foregroundStyle(.gray)
                }
            }
            .padding(.bottom, 32)
            
            inputCard
            addButton
            
            Spacer()
        }
        .onAppear {
            isNameFocused = true
        }
        .padding()
        .padding(.top, 32)
    }
}

#Preview {
    AddNewShoppingItemView(addItemFct: { _ in })
        .background(.green.opacity(0.1))
}
