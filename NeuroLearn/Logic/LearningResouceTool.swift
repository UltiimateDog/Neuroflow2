import FoundationModels
import SwiftUI

@Observable
final class LearningResourceTool: Tool {
    let name = "learningResource"
    let description = "Finds analogies, definitions, or examples for a topic."
    
    @MainActor var lookupHistory: [Lookup] = []

    @Generable
    enum ResourceType: String, CaseIterable {
        case analogy, definition, realWorldExample, visualAid
    }

    @Generable
    struct Arguments {
        let resourceType: ResourceType
        let subject: String
    }

    // Define Lookup here, inside the class
    struct Lookup: Identifiable {
        let id = UUID()
        let type: ResourceType
    }

    func call(arguments: Arguments) async throws -> String {
        await MainActor.run {
            lookupHistory.append(Lookup(type: arguments.resourceType))
        }
        return "Found a great \(arguments.resourceType) for \(arguments.subject)."
    }
}
