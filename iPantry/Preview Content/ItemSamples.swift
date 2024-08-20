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
    
    static var dateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    static func getDate(_ date: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: date) ?? .now
    }
    
    static var sampleItems: [Item] {
        [
            Item(name: "Cherries", purchasedDate: .now, category: Category.fruits, notes: "Ralphs"),
            Item(name: "Apples", purchasedDate: exampleDate, category: Category.fruits, notes: "Aldi"),
            Item(name: "Oranges", purchasedDate: exampleDate, category: Category.fruits, notes: "Aldi"),
            Item(name: "Doritos", purchasedDate: .now.addingTimeInterval(-86400), category: Category.snacks, notes: "Target"),
            Item(name: "Eggs", purchasedDate: .now.addingTimeInterval(-172800), category: Category.dairy, notes: "2 dozen eggs from Costco"),
            Item(name: "Chicken", purchasedDate: getDate("2024-08-07"), category: Category.poultry, dateLabel: "Freeze", qualityDate: getDate("2024-08-1"), notes: ""),
            Item(name: "Flour", purchasedDate: getDate("2024-08-07"), category: Category.poultry, dateLabel: "Best By", qualityDate: getDate("2025-08-1"), notes: ""),
            Item(name: "Carrot", purchasedDate: getDate("2024-08-17"), category: Category.vegetables, dateLabel: "Best By", qualityDate: getDate("2024-08-24"), notes: ""),
            Item(name: "Bread", purchasedDate: getDate("2024-08-17"), category: Category.grains, dateLabel: "Best By", qualityDate: getDate("2024-08-24"), notes: ""),
            Item(name: "Milk", purchasedDate: getDate("2024-08-19"), category: Category.dairy, dateLabel: "Best By", qualityDate: getDate("2024-08-28"), notes: "Costco")
        ]
    }
}
