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
    
    @State private var allSelected: Bool = true
    @State private var categoryToggles: [Category: Bool] = [:]
    
    init() {
        var toggleMap: [Category: Bool] = [:]
        for category in categories {
            toggleMap[category] = false
        }
        _categoryToggles = State(initialValue: toggleMap)
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                Toggle(isOn: $allSelected) {
                    Text("All")
                }
//                .onChange(of: allSelected) {
//                    categories.forEach { category in
//                        categoryToggles[category] = false
//                    }
//                }
                ForEach(categories, id: \.self) { category in
                    Toggle(isOn: Binding(
                        get: { categoryToggles[category] ?? false},
                        set: { newValue in
                            categoryToggles[category] = newValue
                        }
                    )) {
                        Text(category.name)
                    }
                    
                }
            }
            .toggleStyle(.button)
            .fontWeight(.semibold)
        }
    }
}

#Preview {
    let preview = Preview(Category.self)
    preview.addSamples(Category.sampleCategories)
    return CategoriesView()
        .modelContainer(preview.container)
}
