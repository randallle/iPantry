//
//  ItemDetailView.swift
//  iPantry
//
//  Created by Randall Le on 8/5/24.
//

import SwiftUI

struct ItemDetailView: View {
    
    let item: Item
    var body: some View {
        Text("Information about \(item.name.lowercased())")
        Text(item.emoji)
    }
}

#Preview {
    let exampleItem = Item(name: "Cherries", category: "Fruits", emoji: "🍒", daysUntilExpiration: 10)
    return ItemDetailView(item: exampleItem)
}
