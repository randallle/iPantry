//
//  ItemDetailView.swift
//  iPantry
//
//  Created by Randall Le on 8/5/24.
//

import SwiftUI

struct ItemEditorView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var category = "None"
    @State private var purchasedDate = Date.now
    @State private var dateLabel = "None"
    @State private var qualityDate = Date.now
    @State private var notes = ""
    
    let categories: [String] = ["None", "Fruits", "Poultry", "Vegetables", "Baking", "Other"]
    let dateLabels: [String] = ["None", "Best By", "Sell By", "Use By", "Freeze By"]
    let item: Item?
    
    init(item: Item?) {
        UITextField.appearance().clearButtonMode = .whileEditing
        self.item = item
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
                        
                        Section {
                            Text("Create category").tag("Create category")
                        }
                    }
                    
                    DatePicker("Purchased Date", selection: $purchasedDate, in: ...Date(), displayedComponents: .date)
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
                        DatePicker("\(dateLabel) Date", selection: $qualityDate, in: purchasedDate..., displayedComponents: .date)
                    }
                }
                
                Section {
                    TextField("Notes", text: $notes,  axis: .vertical)
                }
            }
            .navigationTitle("\(item == nil ? "Add" : "Edit") Item")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        saveItem()
                        dismiss()
                    } label: {
                        Text("Save")
                    }
                    .disabled(name.isEmpty || category == "None")
                }
            }
        }
        .onAppear {
            if let item {
                name = item.name
                category = item.category
                purchasedDate = item.purchasedDate
                dateLabel = item.dateLabel ?? "None"
                qualityDate = item.qualityDate ?? Date.now
                notes = item.notes
            }
        }
    }
    
    func saveItem() {
        if let item {
            item.name = name
            item.category = category
            item.purchasedDate = purchasedDate
            item.dateLabel = dateLabel
            item.qualityDate = qualityDate
            item.notes = notes
        } else {
            let newItem = Item(
                name: name,
                purchasedDate: purchasedDate,
                category: category,
                dateLabel: dateLabel == "None" ? nil : dateLabel,
                qualityDate: dateLabel == "None" ? nil : qualityDate,
                notes: notes
            )
            modelContext.insert(newItem)
        }
    }
}

#Preview {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    let exampleDate = formatter.date(from: "2024-08-07")!
    
    let exampleItem = Item(name: "Cherries", purchasedDate: exampleDate, category: "Fruits", notes: "")
    return ItemEditorView(item: exampleItem)
}
