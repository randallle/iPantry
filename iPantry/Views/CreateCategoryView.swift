//
//  CreateCategoryView.swift
//  iPantry
//
//  Created by Randall Le on 8/11/24.
//

import SwiftUI

struct CreateCategoryView: View {
    @State private var newCategory = ""
    
    var body: some View {
        Form {
            TextField("Category name", text: $newCategory)
        }
        .navigationTitle("Create category")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button {
                    // more code
                } label: {
                    Text("Save")
                }
                .disabled(newCategory.isEmpty)
            }
        }
    }
}


#Preview {
    CreateCategoryView()
}
