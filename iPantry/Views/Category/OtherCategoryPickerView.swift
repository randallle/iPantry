//
//  OtherCategoryPickerView.swift
//  iPantry
//
//  Created by Randall Le on 8/27/24.
//

import SwiftData
import SwiftUI

struct OtherCategoryPickerView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @Query(sort: [SortDescriptor(\Category.name, order: .forward)]) private var categories: [Category]
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    OtherCategoryPickerView()
}
