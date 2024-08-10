//
//  ItemDetailView.swift
//  iPantry
//
//  Created by Randall Le on 8/5/24.
//

import SwiftUI

struct ItemDetailView: View {
    @State private var name = ""
    @State private var category = "None"
    @State private var purchasedDate = Date.now
    @State private var dateLabel = "None"
    @State private var qualityDate = Date.now
    @State private var notes = ""
    @Binding var isPresented: Bool
    
    let categories: [String] = ["None", "Fruits", "Poultry", "Vegetables", "Baking"]
    let dateLabels: [String] = ["None", "Best By", "Sell By", "Use By", "Freeze By"]
    
    init(isPresented: Binding<Bool>) {
        self._isPresented = isPresented
        UITextField.appearance().clearButtonMode = .whileEditing
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Details") {
                    TextField("Name", text: $name)
                    
                    Picker("Category", selection: $category) {
                        Section {
                            Text("None").tag("None")
                        }
                        Section {
                            ForEach(categories, id: \.self) { category in
                                if category != "None" {
                                    Text(category)
                                }
                            }
                        }
                    }
                    
                    DatePicker("Purchased Date", selection: $purchasedDate, displayedComponents: .date)
                }
                
                Section("Quality") {
                    Picker("Date Label", selection: $dateLabel) {
                        Section {
                            Text("None").tag("None")
                        }
                        ForEach(dateLabels, id: \.self) { label in
                            if label != "None" {
                                Text(label)
                            }
                        }
                    }
                    if dateLabel != "None" {
                        DatePicker("\(dateLabel) Date", selection: $qualityDate, displayedComponents: .date)
                    }
                }
                
                Section {
                    TextField("Notes", text: $notes,  axis: .vertical)
                }
            }
            .navigationTitle("Add Item")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        // more code
                        isPresented = false
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        // more code
                        isPresented = false
                    }
                    .disabled(name.isEmpty)
                }
            }
        }
    }
}

#Preview {
//    let formatter = DateFormatter()
//    formatter.dateFormat = "yyyy-MM-dd"
//    let exampleDate = formatter.date(from: "2024-08-07")!
//    
//    let exampleItem = Item(name: "Cherries", purchasedDate: exampleDate, category: "Fruits", emoji: "🍒")
//    return ItemDetailView(item: exampleItem)
    ItemDetailView(isPresented: .constant(true))
}
