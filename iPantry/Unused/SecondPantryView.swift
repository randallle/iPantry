//
//  SecondPantryView.swift
//  iPantry
//
//  Created by Randall Le on 8/5/24.
//

import SwiftUI

struct SecondPantryView: View {
    @State private var searchTerm = ""
    
    var body: some View {
        NavigationStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .navigationTitle("My Pantry")
                .searchable(text: $searchTerm, prompt: "Search Pantry")
        }
    }
}

#Preview {
    SecondPantryView()
}
