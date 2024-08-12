//
//  CreateCategoryView.swift
//  iPantry
//
//  Created by Randall Le on 8/11/24.
//

import SwiftData
import SwiftUI

struct CreateCategoryView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var newCategory = ""
    @FocusState private var isTextFieldFocused: Bool
    
    init() {
        UITextField.appearance().clearButtonMode = .whileEditing
    }

    var body: some View {
        NavigationStack {
            Form {
                TextField("Category name", text: $newCategory)
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
                        dismiss()
                    } label: {
                        Text("Save")
                    }
                    .disabled(newCategory.isEmpty)
                }
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
