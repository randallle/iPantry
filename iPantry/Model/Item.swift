//
//  Item.swift
//  iPantry
//
//  Created by Randall Le on 8/5/24.
//

import Foundation

struct Item: Identifiable {
    let id = UUID()
    var name: String
    var purchasedDate: Date
    var category: String
    var dateLabel: String? // best, sell, use, freeze
    var qualityDate: Date?
    var emoji: String
    var freezeDate: Date?
    
    // negative value means qualityDate has passed
    var daysRemaining: Int? {
        if let date = qualityDate {
            return Calendar.current.dateComponents([.day], from: .now, to: date).day
        }
        
        return nil
    }
}
