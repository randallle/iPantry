//
//  CategoriesEditorView.swift
//  iPantry
//
//  Created by Randall Le on 8/20/24.
//

import SwiftData
import SwiftUI

struct CategoriesEditorView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query private var categories: [Category]
    @Query private var items: [Item]
    
    // Use binding to reference a state from the parent view
    @Binding var selectedCategory: Category?
    
    @State private var showingAddCategorySheet = false
    @State private var showingDeleteConfirmation = false
    
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
                }
                .onDelete(perform: deleteCategory)
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
            CreateCategoryView(selectedCategory: $selectedCategory)
        }
        .navigationTitle("Edit Category")
        .navigationBarTitleDisplayMode(.inline)
        
    }
    
    func deleteCategory(at offsets: IndexSet) {
        for offset in offsets {
            let category = categories[offset]
            // Re-categorize items of the category to be deleted to be "Other"
            for item in items {
                if item.category == category {
                    item.category = Category(name: "Other")
                }
            }
            // Delete category from model
            modelContext.delete(category)
        }
    }
}

//#Preview {
//    let preview = Preview(Category.self)
//    preview.addSamples(Category.sampleCategories)
//    let samples = preview.getSamples(Category.self)
//
//    @State var selection: Category? = samples.first
//
//    return NavigationStack {
//        CategoriesEditorView(selectedCategory: $selection)
//            .modelContainer(preview.container)
//    }
//}

struct CategoriesEditorView_Previews: PreviewProvider {
    struct WrapperView: View {
        // Manage the selection state here
        @State var selection: Category?
        
        // Get the categories sample data from the preview setup
        var body: some View {
            let preview = Preview(Category.self)
            Task {
                await preview.addSamplesAsync(Category.sampleCategories)
            }
            
            // Pass the state as a binding to the original view
            return CategoriesEditorView(selectedCategory: $selection)
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
