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
    let userModelContainer: ModelContainer
//    let categoryModelContainer: ModelContainer
    
    init() {
        do {
            userModelContainer = try ModelContainer(for: Item.self)
//            categoryModelContainer = try ModelContainer(for: Category.self)
        } catch {
            fatalError("Could not initialize ModelContainer")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(userModelContainer)
//        .modelContainer(categoryModelContainer)
    }
}
