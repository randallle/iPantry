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
                .contentMargins([.leading, .trailing], 20)
            HStack {
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    HStack {
                        Button("Sort by Best By Date") {}
                        Image(systemName: "chevron.down")
                    }
                })
            }
            .font(.callout)
            .padding(.trailing, 20)
            .padding(.top, 10)
            .foregroundColor(.blue)
            
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
                            Text("Expires in \(item.daysRemaining!) days")
                                .font(.caption)
                                .foregroundColor(item.daysRemaining! > 3 ? .secondary : .red)
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
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    let exampleDate = formatter.date(from: "2024-08-07")!
    let exampleDate2 = formatter.date(from: "2024-08-26")!

    let exampleItem = Item(name: "Cherries", purchasedDate: exampleDate, category: "Fruits", qualityDate: exampleDate2, emoji: "🍒")
    return PantryListView(item: exampleItem)
}
