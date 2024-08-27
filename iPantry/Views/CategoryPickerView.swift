//
//  CategoriesEditorView.swift
//  iPantry
//
//  Created by Randall Le on 8/20/24.
//

import SwiftData
import SwiftUI

struct CategoryPickerView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @Query(sort: [SortDescriptor(\Category.name, order: .forward)]) private var categories: [Category]
    @Query private var items: [Item]
    
    // Use binding to reference a state from the parent view
    @Binding var selectedCategory: Category?
    
    @State private var showingAddCategorySheet = false
    @State private var showingDeleteConfirmation = false
    @State private var editingCategory: Category?
    @State private var selectedOffsets: IndexSet?
    
    var otherCategory: Category {
        guard let other = categories.first(where: { $0.name == "Other" }) else {
            fatalError("Could not retrieve category \"Other\".")
        }
        return other
    }
    
    var body: some View {
        List {
            Section {
                ForEach(categories, id: \.self) { category in
                    HStack {
                        Text(category.name)
                        Spacer()
                        if category == selectedCategory {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedCategory = category
                    }
                    .swipeActions(allowsFullSwipe: false) {
                        Button {
                            editingCategory = category
                            showingDeleteConfirmation.toggle()
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                        .tint(category.name == "Other" ? .gray : .red)
                        .disabled(category.name == "Other")
                    }
                }
            } header: {
                Text("Select one")
            } footer: {
                Text("Tap a category to select it or swipe left to delete a category")
            }
        }
        
        Button {
            showingAddCategorySheet.toggle()
        } label: {
            Text("Create Category")
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.accentColor) // Use the accent color for a prominent look
                .cornerRadius(15)
                .padding()
        }
        .sheet(isPresented: $showingAddCategorySheet) {
            // ondismiss
            dismiss()
        }
    content: {
        CreateCategoryView(selectedCategory: $selectedCategory)
    }
    .navigationTitle("Edit Category")
    .navigationBarTitleDisplayMode(.inline)
    .confirmationDialog("Are you sure you want to delete?", isPresented: $showingDeleteConfirmation, titleVisibility: .visible) {
        Button("Delete", role: .destructive) {
            if let deletion = editingCategory {
                deleteCategory(deletion)
            }
        }
        Button("Cancel", role: .cancel) {}
    }
    }
    
    func deleteCategory(_ category: Category) {
        // Re-categorize items of the category to be deleted to be "Other"
        for item in items {
            if item.category == category {
                item.category = otherCategory
            }
        }
        selectedCategory = otherCategory
        
        // Delete category from model
        modelContext.delete(category)
    }
}

struct CategoryPickerView_Previews: PreviewProvider {
    struct WrapperView: View {
        // Manage the selection state here
        @State var selection: Category?
        
        // Get the categories sample data from the preview setup
        var body: some View {
            let preview = Preview(Category.self, Item.self)
            Task {
                await preview.addSamplesAsync(Category.sampleCategories)
                await preview.addSamplesAsync(Item.sampleItems)
            }
            
            // Pass the state as a binding to the original view
            return CategoryPickerView(selectedCategory: $selection)
                .modelContainer(preview.container)
        }
    }
    
    static var previews: some View {
        // Use the wrapper view to manage the state
        return NavigationStack {
            WrapperView()
        }
    }
}
