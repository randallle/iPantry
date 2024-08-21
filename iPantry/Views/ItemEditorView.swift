//
//  ItemDetailView.swift
//  iPantry
//
//  Created by Randall Le on 8/5/24.
//

import SwiftData
import SwiftUI

struct ItemEditorView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @Query var categories: [Category]
    
    @FocusState private var isTextFieldFocused: Bool
    
    @State private var name: String
    @State private var category: Category?
    @State private var purchasedDate: Date
    @State private var dateLabel: String
    @State private var qualityDate: Date
    @State private var notes: String
    
    let dateLabels: [String] = ["None", "Best By", "Sell By", "Use By", "Freeze By"]
    
    var changesPresent: Bool {
        let changes = name == (item?.name ?? "") &&
        category == (item?.category) &&
        Calendar.current.startOfDay(for: purchasedDate) == (Calendar.current.startOfDay(for: item?.purchasedDate ?? Date.now)) &&
        dateLabel == (item?.dateLabel ?? "None") &&
        Calendar.current.startOfDay(for: qualityDate) == (Calendar.current.startOfDay(for: item?.qualityDate ?? Date.now)) &&
        notes == (item?.notes ?? "")
        return !changes
    }
    
    let item: Item?
    
    init(item: Item?) {
        UITextField.appearance().clearButtonMode = .whileEditing
        self.item = item
        
        _name = State(initialValue: item?.name ?? "")
        _category = State(initialValue: item?.category)
        _purchasedDate = State(initialValue: item?.purchasedDate ?? .now)
        _dateLabel = State(initialValue: item?.dateLabel ?? "None")
        _qualityDate = State(initialValue: item?.qualityDate ?? .now)
        _notes = State(initialValue: item?.notes ?? "")
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Details") {
                    TextField("Name", text: $name)
                        .focused($isTextFieldFocused)
                    NavigationLink {
                        CategoriesEditorView(selectedCategory: $category)
                    } label: {
                        HStack {
                            Text("Category")
                            Spacer()
                            Text(category?.name ?? "None")
                                .foregroundStyle(.secondary)
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
                    .disabled(name.isEmpty || category == nil || !changesPresent)
                }
            }
        }
        .onAppear {
            isTextFieldFocused = true
        }
    }
    
    func saveItem() {
        if let item {
            item.name = name.trimmingCharacters(in: .whitespaces)
            item.category = category
            item.purchasedDate = purchasedDate
            item.dateLabel = dateLabel
            item.qualityDate = qualityDate
            item.notes = notes.trimmingCharacters(in: .whitespacesAndNewlines)
        } else {
            let newItem = Item(
                name: name.trimmingCharacters(in: .whitespaces),
                purchasedDate: purchasedDate,
                category: category,
                dateLabel: dateLabel == "None" ? nil : dateLabel,
                qualityDate: dateLabel == "None" ? nil : qualityDate,
                notes: notes.trimmingCharacters(in: .whitespacesAndNewlines)
            )
            modelContext.insert(newItem)
        }
    }
}

#Preview {
    let preview = Preview(Item.self, Category.self)
    preview.addSamples(Category.sampleCategories)
    preview.addSamples(Item.sampleItems)
    
    let samples = preview.getSamples(Item.self)

    return ItemEditorView(item: samples[0])
        .modelContainer(preview.container)
}
