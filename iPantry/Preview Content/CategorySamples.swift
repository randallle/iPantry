//
//  ItemSamples.swift
//  iPantry
//
//  Created by Randall Le on 8/18/24.
//

import Foundation

extension Category {
    static let fruits = Category(name: "Fruits")
    static let snacks = Category(name: "Snacks")
    static let poultry = Category(name: "Poultry")
    static let dairy = Category(name: "Dairy")
    static let vegetables = Category(name: "Vegetables")
    static let baking = Category(name: "Baking")
    static let grains = Category(name: "Grains")
    static let other = Category(name: "Other")
    
    static var sampleCategories: [Category] {
        [fruits, snacks, poultry, dairy, vegetables, baking, grains, other]
    }
}
