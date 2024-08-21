//
//  CategoriesEditorView.swift
//  iPantry
//
//  Created by Randall Le on 8/20/24.
//

import SwiftData
import SwiftUI

struct CategoriesEditorView: View {
    @Query private var categories: [Category]
    
    // Use binding to reference a state from the parent view
    @Binding var selectedCategory: Category?

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    let preview = Preview(Category.self)
    preview.addSamples(Category.sampleCategories)
    let samples = preview.getSamples(Category.self)

    return CategoriesEditorView(selectedCategory: .constant(samples[0]))
        .modelContainer(preview.container)
}
