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
    
//    let categories: [String] = ["All", "Fruits", "Poultry", "Vegetables", "Baking", "+"]
//    @State private var categoryToggles: [Bool] = [true, false, false, false, false, false]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(categories) { category in
                    Text(category.name)
                }
                
//                ForEach(0..<categories.count) { index in
//                    Toggle(isOn: $categoryToggles[index]) {
//                        Text(categories[index])
//                    }
//                    .toggleStyle(.button)
//                    .fontWeight(.semibold)
//                    // create .toggleStyle
//                }
            }
        }
    }
}

#Preview {
    CategoriesView()
}
