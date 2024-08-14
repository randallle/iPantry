//
//  CategoryMockData.swift
//  iPantry
//
//  Created by Randall Le on 8/13/24.
//

import Foundation

extension Category {
    static var categoryMockData: [Category] {
        [
            Category(name: "All", isSelected: true),
            Category(name: "Fruit", isSelected: false),
            Category(name: "Poultry", isSelected: false),
            Category(name: "Vegetables", isSelected: false),
            Category(name: "Snacks", isSelected: false),
            Category(name: "Produce", isSelected: false),
        ]
    }
}
