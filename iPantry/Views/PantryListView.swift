//
//  PantryListView.swift
//  iPantry
//
//  Created by Randall Le on 8/5/24.
//

import SwiftData
import SwiftUI

struct PantryListView: View {
    @Environment(\.modelContext) var modelContext
    @Query var items: [Item]
    
    @State private var searchTerm = ""
    @State private var showingAddSheet = false
    @State private var showingSortOptions = false
    
    var body: some View {
        NavigationStack {
            Group {
                if items.isEmpty {
                    ContentUnavailableView("Add an item.", systemImage: "bag.fill")
                } else {
                    List {
                        HStack {
                            CategoriesView()
                            Button("Sort", systemImage: "arrow.up.arrow.down") {
                                showingSortOptions.toggle()
                            }
                            .labelStyle(.iconOnly)
                            .foregroundColor(.accentColor)
                            .padding(.leading)
                        }
                        .listRowSeparator(.hidden)
                        .padding(.leading, -3)
                        ForEach(items) { item in
                            NavigationLink(value: item) {
                                HStack {
                                    VStack(alignment: .leading, spacing: 5) {
                                        Text(item.name)
                                            .fontWeight(.semibold)
                                            .lineLimit(1)
                                        Text(item.daysRemaining != nil ? "Expires in \(item.daysRemaining!) days" : "No expiration provided")
                                        
                                            .font(.caption)
                                            .foregroundColor((item.daysRemaining ?? 4) > 3 ? .secondary : .red)
                                    }
                                }
                            }
                        }
                        .onDelete(perform: deleteItem)
                    }
                    .listStyle(.plain)
                }
            }
            .confirmationDialog("Sort Options", isPresented: $showingSortOptions) {
                Button("Quality Date") {}
                Button("Date Purchased") {}
                Button("Item Name") {}
            } message: {
                Text("Sort Options")
            }
            .searchable(text: $searchTerm, placement: .navigationBarDrawer, prompt: "Search Pantry")
            .navigationTitle("My Pantry")
            .navigationDestination(for: Item.self) { item in
                ItemDetailsView(item: item)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .primaryAction) {
                    Button("Add Item", systemImage: "plus") {
                        showingAddSheet.toggle()
                    }
                    .sheet(isPresented: $showingAddSheet) {
                        ItemEditorView(item: nil)
                    }
                }
            }
            
        }
    }
    
    func deleteItem(at offsets: IndexSet) {
        for offset in offsets {
            let item = items[offset]
            modelContext.delete(item)
        }
    }
}

#Preview {
    let preview = Preview(Item.self, Category.self)
    preview.addSamples(Category.sampleCategories)
    preview.addSamples(Item.sampleItems)
    
    return PantryListView()
        .modelContainer(preview.container)
}
