//
//  PreviewContainer.swift
//  iPantry
//
//  Created by Randall Le on 8/13/24.
//

import Foundation
import SwiftData

struct Preview {
    let container: ModelContainer
    
    init(_ models: any PersistentModel.Type...) {
        let schema = Schema(models)
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        do {
            container = try ModelContainer(for: schema, configurations: config)
        } catch {
            print(error.localizedDescription)
            fatalError("Could not create preview container")
        }
    }
    
    @MainActor
    func addSamples(_ samples: [any PersistentModel]) {
        samples.forEach { sample in
            container.mainContext.insert(sample)
        }
    }
    
    @MainActor
    func addSamplesAsync(_ samples: [any PersistentModel]) async {
        samples.forEach { sample in
            container.mainContext.insert(sample)
        }
    }
    
    @MainActor
    func getSamples<T: PersistentModel>(_ model: T.Type) -> [T] {
        let context = container.mainContext
        let request = FetchDescriptor<T>()
        
        do {
            let samples = try context.fetch(request)
            return samples
        } catch {
            print("Failed to fetch model: \(error)")
            return []
        }
    }
    
    @MainActor
    func getSamplesAsync<T: PersistentModel>(_ model: T.Type) async -> [T]  {
        let context = container.mainContext
        let request = FetchDescriptor<T>()
        
        do {
            let samples = try context.fetch(request)
            return samples
        } catch {
            print("Failed to fetch model: \(error)")
            return []
        }
    }
}
