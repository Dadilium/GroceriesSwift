//
//  SettingsRow.swift
//  GroceriesSwift
//
//  Created by Antoine ROY on 08/05/2026.
//

import SwiftUI

enum SettingsRowState {
    case base
    case complete
    case delete
}

struct SettingsRow: View {

    
    var title: String
    var subtitle: String?
    var icon: String
    var state: SettingsRowState
    
    
    private var iconBackground: Color {
        switch state {
        case .base:
            return .gray
        case .complete:
            return .green
        case .delete:
            return .red
        }
    }
    
    private var titleForeground: Color {
        switch state {
        case .base:
            return .primary
        case .complete:
            return .green
        case .delete:
            return .red
        }
    }

    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: icon)
                .resizable()
                .frame(width: 20, height: 20)
                .padding(16)
                .background(iconBackground.opacity(0.4), in: RoundedRectangle(cornerRadius: 10))
                .padding(8)
                .foregroundStyle(.black)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.title3.weight(.semibold))
                    .foregroundColor(titleForeground)
                
                if let subtitle {
                    Text(subtitle)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                
            }
        }
    }
}

#Preview {
    List {
        SettingsRow(title: "Items in basket", subtitle: "2 of 5", icon: "clock", state: .base)
        SettingsRow(title: "Clear basket", icon: "checkmark", state: .complete)
        SettingsRow(title: "Delete all items", icon: "trash", state: .delete)
        SettingsRow(title: "Groceries", subtitle: "v1.0", icon: "gear", state: .base)

    }
}
