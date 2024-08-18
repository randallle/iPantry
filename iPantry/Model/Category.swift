//
//  Category.swift
//  iPantry
//
//  Created by Randall Le on 8/11/24.
//

import Foundation
import SwiftData

@Model
class Category: Identifiable, Hashable {
    let id = UUID()
    let name: String
    var isSelected = false
    
    init(name: String, isSelected: Bool = false) {
        self.name = name
        self.isSelected = isSelected
    }
}
