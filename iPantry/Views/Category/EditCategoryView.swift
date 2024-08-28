//
//  EditCategoryView.swift
//  iPantry
//
//  Created by Randall Le on 8/27/24.
//

import SwiftUI

struct EditCategoryView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @FocusState private var isTextFieldFocused: Bool
    
    @State private var categoryName: String
    
    let category: Category?
    
    init(category: Category?) {
        self.category = category
        _categoryName = State(initialValue: category?.name ?? "")
        UITextField.appearance().clearButtonMode = .whileEditing
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Category name", text: $categoryName)
                    .focused($isTextFieldFocused)
            }
            .scrollDisabled(true)
            .navigationTitle("\(category == nil ? "Create" : "Edit") Category")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        if let category = category {
                            category.name = categoryName
                            try? modelContext.save()
                        } else {
                            let newCategory = Category(name: categoryName)
                            modelContext.insert(newCategory)
                        }
                        dismiss()
                    } label: {
                        Text("Save")
                    }
                    .disabled(categoryName.isEmpty || categoryName == category?.name)
                }
            }
        }
        .onAppear {
            isTextFieldFocused = true
        }
    }
}

#Preview {
    let preview = Preview(Category.self)
    preview.addSamples(Category.sampleCategories)
    
    let samples = preview.getSamples(Category.self)
    return NavigationStack {
        EditCategoryView(category: samples.first)
            .modelContainer(preview.container)
    }
}
