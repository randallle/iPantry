//
//  ItemSamples.swift
//  iPantry
//
//  Created by Randall Le on 8/18/24.
//

import Foundation

extension Item {
    static var exampleDate: Date = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: "2024-08-07") ?? .now
    }()
    
    static var sampleItems: [Item] {
        [
            Item(name: "Cherries", purchasedDate: .now, category: Category.fruits, notes: "Ralphs"),
            Item(name: "Apples", purchasedDate: exampleDate, category: Category.fruits, notes: "Aldi"),
            Item(name: "Oranges", purchasedDate: exampleDate, category: Category.fruits, notes: "Aldi"),
            Item(name: "Doritos", purchasedDate: .now.addingTimeInterval(-86400), category: Category.snacks, notes: "Target"),
            Item(name: "Eggs", purchasedDate: .now.addingTimeInterval(-172800), category: Category.dairy, notes: "2 dozen eggs from Costco")
        ]
    }
}
