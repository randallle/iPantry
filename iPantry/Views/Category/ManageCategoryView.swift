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
    @Query private var items: [Item]
    
    @State private var showingDeleteConfirmation: Bool = false
    @State private var showingManageCategoryNameSheet: Bool = false
    @State private var categoryToEdit: Category?
    
    @Binding var selectedCategory: Category?
    
    init(selectedCategory: Binding<Category?>) {
        _selectedCategory = selectedCategory
    }
    
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
                                .swipeActions(allowsFullSwipe: false) {
                                    Button("Delete", systemImage: "trash") {
                                        categoryToEdit = category
                                        showingDeleteConfirmation.toggle()
                                    }
                                    .tint(.red)
                                    
                                    Button("Edit", systemImage: "square.and.pencil") {
                                        // more code here
                                        categoryToEdit = category
                                        showingManageCategoryNameSheet.toggle()
                                    }
                                    .tint(.yellow)
                                }
                        }
                    }
                } header: {
                    Text("Categories")
                } footer: {
                    Text("Swipe to delete or rename a category")
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
            .confirmationDialog("Are you sure you want to delete \(categoryToEdit?.name ?? "")?", isPresented: $showingDeleteConfirmation, titleVisibility: .visible) {
                Button("Delete", role: .destructive) {
                    if let categoryToEdit {
                        deleteCategory(categoryToEdit)
                    }
                }
                Button("Cancel", role: .cancel) {}
            }
            .sheet(isPresented: $showingManageCategoryNameSheet) {
                ManageCategoryNameView(selectedCategory: $selectedCategory, category: categoryToEdit)
            }
        }
    }
    
    func deleteCategory(_ category: Category) {
        // Re-categorize items of the category to be deleted to be "Other"
        for item in items {
            if item.category == category {
                item.category = otherCategory
            }
        }
        modelContext.delete(category)
        
        selectedCategory = otherCategory
    }
}

#Preview {
    let preview = Preview(Category.self, Item.self)
    preview.addSamples(Category.sampleCategories)
    preview.addSamples(Item.sampleItems)
    
    let samples = preview.getSamples(Category.self)
    
    return NavigationStack {
        ManageCategoryView(selectedCategory: .constant(samples.first))
            .modelContainer(preview.container)
    }
}
