//
//  CategoryEditorView.swift
//  iPantry
//
//  Created by Randall Le on 8/27/24.
//

import SwiftData
import SwiftUI

struct CategoryEditorView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @Query(sort: [SortDescriptor(\Category.name, order: .forward)]) private var categories: [Category]
    
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
            }
            .navigationTitle("Edit categories")
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
        CategoryEditorView()
            .modelContainer(preview.container)
    }
}
