//
//  CategoriesView.swift
//  iPantry
//
//  Created by Randall Le on 8/5/24.
//

import SwiftData
import SwiftUI

struct CategoriesView: View {
    @Environment(\.modelContext) var modelContext
    @Query var categories: [Category]

    @State private var categoryToggles: [Category: Bool] = [:]
    
    init() {
        
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(categories, id: \.self) { category in
                    Toggle(isOn: Binding(
                        get: { categoryToggles[category] ?? false},
                        set: { newValue in
                            categoryToggles[category] = newValue
                            category.isSelected = newValue
                        }
                    )) {
                        Text(category.name)
                    }
                    .toggleStyle(.button)
                    .fontWeight(.semibold)
                }
            }
            .onAppear {
                for category in categories {
                    categoryToggles[category] = category.isSelected
                }
            }
        }
    }
}

#Preview {
    let preview = Preview(Category.self)
    preview.addExamples(Category.sampleCategories)
    return CategoriesView()
        .modelContainer(preview.container)
}
