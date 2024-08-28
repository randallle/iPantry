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
        
    // Use binding to reference a state from the parent view
    @Binding var selectedCategory: Category?
    
    init(selectedCategory: Binding<Category?>) {
        _selectedCategory = selectedCategory
    }
    
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
    
    let samples = preview.getSamples(Category.self)
    
    return NavigationStack {
        OtherCategoryPickerView(selectedCategory: .constant(samples.first))
            .modelContainer(preview.container)
    }
}
