//
//  CategoryEditorView.swift
//  iPantry
//
//  Created by Randall Le on 8/27/24.
//

import SwiftData
import SwiftUI

struct ManageCategoryView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @Query(sort: [SortDescriptor(\Category.name, order: .forward)]) private var categories: [Category]
    
    @State private var showingDeleteConfirmation: Bool = false
    
    var otherCategory: Category {
        guard let other = categories.first(where: { $0.name == "Other" }) else {
            fatalError("Could not retrieve category \"Other\".")
        }
        return other
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(categories, id: \.self) { category in
                        if category.name != "Other" {
                            Text(category.name)
                        }
                    }
                } header: {
                    Text("Categories")
                } footer: {
                    Text("Swipe to delete or rename a category")
                }
                .swipeActions(allowsFullSwipe: false) {
                    Button("Delete", systemImage: "trash") {
                        // more code here
                        showingDeleteConfirmation.toggle()
                    }
                    .tint(.red)
                    Button("Edit", systemImage: "square.and.pencil") {
                        // more code here
                    }
                    .tint(.orange)
                }
            }
            .navigationTitle("Manage Categories")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
            
            
        }
    }
}

#Preview {
    let preview = Preview(Category.self)
    preview.addSamples(Category.sampleCategories)
    return NavigationStack {
        ManageCategoryView()
            .modelContainer(preview.container)
    }
}
