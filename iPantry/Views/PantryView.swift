//
//  PantryView.swift
//  iPantry
//
//  Created by Randall Le on 8/5/24.
//

import SwiftUI

struct PantryView: View {
    let items: [Item] = [
        Item(name: "Chicken", category: "Poultry", emoji: "🍗", daysUntilExpiration: 10),
        Item(name: "Cherries", category: "Fruits", emoji: "🍒", daysUntilExpiration: 10)
    ]
    
    var body: some View {
        
        // Header
        HStack {
            Text("My Pantry")
                .font(.largeTitle)
                .fontWeight(.bold)
            Spacer()
        }
        .padding([.top, .leading], 20)
        
        // Categories
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                Button("All") {}
                    .padding(10)
                    .background(.white)
                    .foregroundColor(.black)
                    .cornerRadius(10)
                    .shadow(color: .gray, radius: 7)

                
                ForEach(0..<10) {
                    Button("Category \($0)") {}
                        .padding(10)
                        .background(.white)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        .shadow(color: .gray, radius: 7)
                }
            }
            .fontWeight(.bold)
            .padding(20)
        }
        
        // Sort by button
        HStack {
            Spacer()
            HStack {
                Button("Sort by Best By Date") {}
                Image(systemName: "chevron.down")
            }
        }
        .padding(20)
        .foregroundColor(.blue)
        
        // Items list
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(items) { item in
                        NavigationLink {
                            Text("Details about \(item.name)")
                        } label: {
                            ItemRowView(item: item)
                        }
                        .cornerRadius(10)
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    PantryView()
}
