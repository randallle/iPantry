//
//  ItemRowView.swift
//  iPantry
//
//  Created by Randall Le on 8/5/24.
//

import SwiftUI

struct ItemRowView: View {
    let item: Item
    
    var body: some View {
        HStack {
            Text(item.emoji)
                .font(.system(size: 40))
                .frame(width: 60, height: 60)
                .background(Color.gray)
                .cornerRadius(10)
            
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                Text("Expires in 4 days")
                    .font(.caption)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(.tertiary)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    let exampleItem = Item(name: "Cherries", category: "Fruits", emoji: "🍒", daysUntilExpiration: 10)
    return ItemRowView(item: exampleItem)
}
