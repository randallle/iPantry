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
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    static let other = Category(name: "Other")
}
