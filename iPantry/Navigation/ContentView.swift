//
//  ContentView.swift
//  iPantry
//
//  Created by Randall Le on 8/5/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        PantryListView(item: Item(name: "Chicken", category: "Poultry", emoji: "🍗", daysUntilExpiration: 10))
    }
}

#Preview {
    ContentView()
}
