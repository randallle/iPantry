//
//  OtherCategoryPickerView.swift
//  iPantry
//
//  Created by Randall Le on 8/27/24.
//

import SwiftData
import SwiftUI

struct OtherCategoryPickerView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @Query(sort: [SortDescriptor(\Category.name, order: .forward)]) private var categories: [Category]
    
    @State private var selectedCategory: Category?
    
    var body: some View {
        Form {
            Picker("Categories", selection: $selectedCategory) {
                ForEach(categories, id: \.self) { category in
                    Text(category.name).tag(category as Category?)
                }
            }
            .pickerStyle(.inline)
            
            Section {
                List {
                    Button("Create Category") {}
                    Button("Manage Categories") {}
                }
            } header: {
                Text("More options")
            }
        }
        .navigationTitle("Select Category")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let preview = Preview(Category.self, Item.self)
    Task {
        await preview.addSamplesAsync(Category.sampleCategories)
        await preview.addSamplesAsync(Item.sampleItems)
    }
    
    return NavigationStack {
        OtherCategoryPickerView()
            .modelContainer(preview.container)
    }
}
