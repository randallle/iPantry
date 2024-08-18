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
    @State private var showingItemEditor = false
    
    var body: some View {
        List {
            HStack {
                Text("Item Name")
                Spacer()
                Text(item.name)
                    .foregroundColor(.secondary)
            }
            HStack {
                Text("Category")
                Spacer()
                Text(item.category?.name ?? "There was an error")
                    .foregroundColor(.secondary)
            }
            Section {
                HStack {
                    Text(item.dateLabel ?? "No label")
                    Spacer()
                    Text(item.qualityDate ?? .now, format: .dateTime.day().month().year())
                        .foregroundColor(.secondary)
                }
            } header: {
                Text("Quality")
            } footer: {
                Text("\(item.daysRemaining ?? 0) days remaining")
            }
            
            Section("Notes") {
                Text(item.notes)
            }
            
            Button("Create Category") { showingAddCategorySheet.toggle() }
        }
        .navigationTitle("Item Details")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(isPresented: $showingAddCategorySheet){
            CreateCategoryView()
        }
        .scrollBounceBehavior(.basedOnSize)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Edit") {
                    showingItemEditor.toggle()
                }
                .sheet(isPresented: $showingItemEditor) {
                    ItemEditorView(item: item)
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
        let exampleItem = Item(name: "Cherries", purchasedDate: exampleDate, category: Category(name: "Fruits"), notes: "")
        return ItemDetailsView(item: exampleItem)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
