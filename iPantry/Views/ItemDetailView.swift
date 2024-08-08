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
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    let exampleDate = formatter.date(from: "2024-08-07")!
    
    let exampleItem = Item(name: "Cherries", purchasedDate: exampleDate, category: "Fruits", emoji: "🍒")
    return ItemDetailView(item: exampleItem)
}
