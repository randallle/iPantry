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
    
    @State private var newCategoryName = ""
    @FocusState private var isTextFieldFocused: Bool
    
    init() {
        UITextField.appearance().clearButtonMode = .whileEditing
    }
    
    var body: some View {
        Form {
            TextField("Category name", text: $newCategoryName)
                .focused($isTextFieldFocused)
        }
        .navigationTitle("Create category")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button {
                    // more code
                    let newCategory = Category(name: newCategoryName)
                    modelContext.insert(newCategory)
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


#Preview {
    CreateCategoryView()
}
