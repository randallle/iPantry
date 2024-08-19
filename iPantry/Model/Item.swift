//
//  Item.swift
//  iPantry
//
//  Created by Randall Le on 8/5/24.
//

import Foundation
import SwiftData

@Model
class Item {
    var name: String
    var purchasedDate: Date
    
    var category: Category?
    var dateLabel: String? // best, sell, use, freeze
    var qualityDate: Date?
    var notes: String = ""
    
    // negative value means qualityDate has passed
    var daysRemaining: Int? {
        if let date = qualityDate {
            return Calendar.current.dateComponents([.day], from: .now, to: date).day
        }
        
        return nil
    }
    
    init(name: String, purchasedDate: Date, category: Category? = nil, dateLabel: String? = nil, qualityDate: Date? = nil, notes: String) {
        self.name = name
        self.purchasedDate = purchasedDate
        self.category = category
        self.dateLabel = dateLabel
        self.qualityDate = qualityDate
        self.notes = notes
    }
}
