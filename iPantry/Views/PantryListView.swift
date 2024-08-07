//
//  PantryListView.swift
//  iPantry
//
//  Created by Randall Le on 8/5/24.
//

import SwiftUI

struct PantryListView: View {
    let item: Item
    @State private var searchTerm = ""
    
    var body: some View {
        NavigationStack {
            CategoriesView()
//                .padding(.leading, 20)
                .contentMargins([.leading, .trailing], 20)
            List(0..<20) { number in
                NavigationLink {
                    ItemDetailView(item: item)
                        .navigationTitle(item.name)
                        .navigationBarTitleDisplayMode(.inline)
                } label: {
                    HStack {
                        Text(item.emoji)
                            .font(.system(size: 40))
                            .frame(width: 60, height: 60)
                            .background(.gray)
                            .cornerRadius(10)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text(item.name)
                                .fontWeight(.semibold)
                                .lineLimit(1)
                            Text("Expires in 4 days")
                                .font(.caption)
                                .foregroundColor(item.daysUntilExpiration > 3 ? .secondary : .red)
                        }
                    }
                }
            }
            .navigationTitle("My Pantry")
            .searchable(text: $searchTerm, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search Pantry")
        }
    }
}

#Preview {
    let exampleItem = Item(name: "Cherries", category: "Fruits", emoji: "🍒", daysUntilExpiration: 10)
    return PantryListView(item: exampleItem)
}
