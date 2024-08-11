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
    let id = UUID()
    var name: String
    var purchasedDate: Date
    var category: String
    var dateLabel: String? // best, sell, use, freeze
    var qualityDate: Date?
    var emoji = "🩵"
    var freezeDate: Date?
    var notes: String = ""
    
    // negative value means qualityDate has passed
    var daysRemaining: Int? {
        if let date = qualityDate {
            return Calendar.current.dateComponents([.day], from: .now, to: date).day
        }
        
        return nil
    }
    
    init(name: String, purchasedDate: Date, category: String, dateLabel: String? = nil, qualityDate: Date? = nil, freezeDate: Date? = nil) {
        self.name = name
        self.purchasedDate = purchasedDate
        self.category = category
        self.dateLabel = dateLabel
        self.qualityDate = qualityDate
        self.freezeDate = freezeDate
    }
}
