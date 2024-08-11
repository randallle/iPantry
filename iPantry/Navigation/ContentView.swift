//
//  ContentView.swift
//  iPantry
//
//  Created by Randall Le on 8/5/24.
//

import SwiftData
import SwiftUI

func exampleItem() -> Item {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    let exampleDate = formatter.date(from: "2024-08-07")!
    let exampleDate2 = formatter.date(from: "2024-08-26")!

    return Item(name: "Cherries", purchasedDate: exampleDate, category: "Fruits", qualityDate: exampleDate2)
}

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var items: [Item]
    
    var body: some View {
        PantryListView(items: items)
    }
}

#Preview {
    ContentView()
}
