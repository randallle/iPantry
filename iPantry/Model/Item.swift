//
//  Item.swift
//  iPantry
//
//  Created by Randall Le on 8/5/24.
//

import Foundation

class Item: Identifiable {
    let id = UUID()
    var name: String
//    var purchasedDate: Date
    var category: String
//    var sellByDate: Date?
//    var bestByDate: Date?
//    var shelfLife: Int?
    var emoji: String
    var daysUntilExpiration: Int
    
    init(name: String, category: String, emoji: String, daysUntilExpiration: Int) {
        self.name = name
        self.category = category
        self.emoji = emoji
        self.daysUntilExpiration = daysUntilExpiration
    }
}

//- [ ] item name
//- [ ] purchased date
//- [ ] category
//- [ ] sell by/best buy date
//- [ ] freeze date
//- [ ] shelf life (auto populated or entered by user)
//- [ ] location
//- [ ] refrigerated
//- [ ] barcode feature

