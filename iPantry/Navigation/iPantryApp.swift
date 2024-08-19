//
//  iPantryApp.swift
//  iPantry
//
//  Created by Randall Le on 8/5/24.
//

import SwiftData
import SwiftUI

@main
struct iPantryApp: App {
    let modelContainer: ModelContainer
    
    init() {
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
        
        let schema = Schema([Item.self, Category.self])
        let config = ModelConfiguration("PantryItems", schema: schema)
        
        do {
            modelContainer = try ModelContainer(for: schema, configurations: config)
        } catch {
            fatalError("Could not initialize ModelContainer")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    loadCategories()
                }
        }
        .modelContainer(modelContainer)
    }
    
    @MainActor
    private func loadCategories() {
        let context = modelContainer.mainContext
        let request = FetchDescriptor<Category>()
        
        do {
            let categories = try context.fetch(request)
            if categories.isEmpty {
                let defaultCategories = ["Fruits", "Poultry", "Vegetables", "Baking"]
                context.insert(Category(name: "All"))
                for category in defaultCategories {
                    let newCategory = Category(name: category)
                    context.insert(newCategory)
                }
                try context.save()
            }
        } catch {
            print("Failed to fetch or save default categories: \(error)")
        }
    }
}
