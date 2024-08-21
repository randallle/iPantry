//
//  CreateCategoryView.swift
//  iPantry
//
//  Created by Randall Le on 8/11/24.
//

import SwiftData
import SwiftUI

struct CreateCategoryView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @Binding private var selectedCategory: Category?
    
    @State private var newCategoryName = ""
    @FocusState private var isTextFieldFocused: Bool
    
    init(selectedCategory: Binding<Category?>) {
        _selectedCategory = selectedCategory
        UITextField.appearance().clearButtonMode = .whileEditing
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Category name", text: $newCategoryName)
                    .focused($isTextFieldFocused)
            }
            .navigationTitle("Create category")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        // more code
                        let newCategory = Category(name: newCategoryName)
                        modelContext.insert(newCategory)
                        selectedCategory = newCategory
                        dismiss()
                    } label: {
                        Text("Save")
                    }
                    .disabled(newCategoryName.isEmpty)
                }
            }
            .onAppear {
                isTextFieldFocused = true
            }
        }
    }
}


#Preview {
    let preview = Preview(Category.self)
    preview.addSamples(Category.sampleCategories)
    
    let samples = preview.getSamples(Category.self)
    return NavigationStack {
        CreateCategoryView(selectedCategory: .constant(samples.first))
    }
}
