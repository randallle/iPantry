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
    
    // create enum of categories that reads from category samples
    // use it in sampleItems
    
    static var sampleItems: [Item] {
        [
            Item(name: "Pears", purchasedDate: .now, category: nil, notes: "Aldi"),
            Item(name: "Chicken wings", purchasedDate: .now.addingTimeInterval(-86400), category: nil, notes: "Ralphs"),
            Item(name: "Doritos", purchasedDate: exampleDate, category: nil, notes: "Aldi"),
        ]
    }
}
