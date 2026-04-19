import FoundationModels
import Observation

@Observable @MainActor
final class LearningPlanner {
    private(set) var plan: LearningPlan.PartiallyGenerated?
    private(set) var resourceTool: LearningResourceTool
    private(set) var imageTool: ImageSearchTool
    private var session: LanguageModelSession
    
    init(subject: String) {
        // 1. Create the tools as local constants first.
        // This avoids using 'self' before the class is ready.
        let resource = LearningResourceTool()
        let image = ImageSearchTool()
        
        // 2. Initialize the session using these local constants.
        self.session = LanguageModelSession(
            tools: [resource, image],
            instructions: Instructions {
                "Act as a TEACCH-certified specialist."
                "1. Use 'Visual Structure': Define clear beginnings and ends for every explanation."
                "2. Minimize Language: Use short, direct sentences. Avoid metaphors that might confuse."
                "3. Explicit Meaning: Don't imply anything. If a concept is important, say 'This is important because...'"
                "4. Chunking: Ensure no step has more than 3 sentences."
                "5. Dyslexia-Friendly: Avoid long, complex words when simple ones work."
            }
        )
        // 3. Finally, assign the local variables to your stored properties.
        // Now that all properties have values, 'self' is fully initialized.
        self.resourceTool = resource
        self.imageTool = image
    }

    func generateLearningPlan(for subject: String) async throws {
        let stream = session.streamResponse(
            generating: LearningPlan.self,
            includeSchemaInPrompt: false
        ) {
            "Create a visual learning plan for: \(subject)"
        }

        for try await partialResponse in stream {
            self.plan = partialResponse.content
        }
    }
}
