//
//  AddItemView.swift
//  iPantry
//
//  Created by Randall Le on 8/11/24.
//

import SwiftData
import SwiftUI

struct ItemDetailsView: View {
    let item: Item
    
    @State private var showingAddCategorySheet = false
    
    var body: some View {
        ScrollView {
            Text(item.name)
            Text(item.category)
            Text(item.notes)
            Button("Create category") {
                // more code here
                showingAddCategorySheet.toggle()
            }
        }
        .navigationTitle(item.name)
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(isPresented: $showingAddCategorySheet){
            CreateCategoryView()
        }
        .scrollBounceBehavior(.basedOnSize)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Edit") {
                    // more code here
                }
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Item.self, configurations: config)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let exampleDate = formatter.date(from: "2024-08-07")!
        let exampleItem = Item(name: "Cherries", purchasedDate: exampleDate, category: "Fruits", notes: "")
        return ItemDetailsView(item: exampleItem)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
