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
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(items) { item in
                    NavigationLink(value: item) {
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
                                Text(item.daysRemaining != nil ? "Expires in \(item.daysRemaining!) days" : "No expiration provided")
                                
                                    .font(.caption)
                                    .foregroundColor((item.daysRemaining ?? 4) > 3 ? .secondary : .red)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteItem)
            }
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
            .searchable(text: $searchTerm, placement: .navigationBarDrawer(displayMode: .automatic), prompt: "Search Pantry")
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
    //    let formatter = DateFormatter()
    //    formatter.dateFormat = "yyyy-MM-dd"
    //    let exampleDate = formatter.date(from: "2024-08-07")!
    //    let exampleDate2 = formatter.date(from: "2024-08-26")!
    //
    //    let exampleItem = Item(name: "Cherries", purchasedDate: exampleDate, category: "Fruits", qualityDate: exampleDate2, notes: "")
    //    return PantryListView(items: [exampleItem, exampleItem])
    PantryListView()
}
