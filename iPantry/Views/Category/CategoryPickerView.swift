//
//  OtherCategoryPickerView.swift
//  iPantry
//
//  Created by Randall Le on 8/27/24.
//

import SwiftData
import SwiftUI

struct CategoryPickerView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @Query(sort: [SortDescriptor(\Category.name, order: .forward)]) private var categories: [Category]
        
    // Use binding to reference a state from the parent view
    @Binding var selectedCategory: Category?
    
    @State private var showingManageCategoryNameSheet: Bool = false
    @State private var showingManageCategorySheet: Bool = false
    
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
        }
        Group {
            Button {
                showingManageCategoryNameSheet.toggle()
            } label: {
                Text("Create Category")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.accentColor) // Use the accent color for a prominent look
                    .cornerRadius(15)
                    .padding(.horizontal)
                    .padding(.top, 10)
            }
            Button {
                showingManageCategorySheet.toggle()
            } label: {
                Text("Manage Categories")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.accentColor) // Use the accent color for a prominent look
                    .cornerRadius(15)
                    .padding(.horizontal)
                    .padding(.top, 10)
            }
        }
        
        
        .navigationTitle("Select Category")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showingManageCategoryNameSheet) {
            ManageCategoryNameView(selectedCategory: $selectedCategory, category: nil)
        }
        .sheet(isPresented: $showingManageCategorySheet) {
            ManageCategoryView(selectedCategory: $selectedCategory)
        }
        
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
        CategoryPickerView(selectedCategory: .constant(samples.first))
            .modelContainer(preview.container)
    }
}
