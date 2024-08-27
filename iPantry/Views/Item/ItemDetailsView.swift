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
        }
        .navigationTitle("Item Details")
        .navigationBarTitleDisplayMode(.inline)
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
    let preview = Preview(Item.self, Category.self)
    preview.addSamples(Category.sampleCategories)
    preview.addSamples(Item.sampleItems)
    
    let samples = preview.getSamples(Item.self)
    return NavigationStack {
        ItemDetailsView(item: samples[0])
            .modelContainer(preview.container)
    }
}
