//
//  ImageSeachTool.swift
//  NeuroLearn
//
//  Created by Dev Jr. 15 on 18/04/26.
//

import FoundationModels
import SwiftUI

@Observable
final class ImageSearchTool: Tool {
    let name = "imageSearch"
    let description = "Finds a high-quality educational image URL for a topic."
    @MainActor var lastSearch: String?

    @Generable
    struct Arguments {
        let searchQuery: String
    }

    // In ImageSearchTool.swift
    func call(arguments: Arguments) async throws -> String {
        await MainActor.run { lastSearch = arguments.searchQuery }
        
        // For testing, return a guaranteed high-quality space image
        return "https://images.unsplash.com/photo-1451187580459-43490279c0fa?auto=format&fit=crop&q=80&w=1000"
    }
}
