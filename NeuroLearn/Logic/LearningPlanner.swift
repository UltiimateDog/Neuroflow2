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
                "Act as a precise academic tutor."
                "1. Generate 5 UNIQUE multiple-choice questions. Do not repeat concepts."
                "2. For each question, ensure EXACTLY one 'correctAnswerIndex' matches the right option."
                "3. Double-check that the 'correctAnswerIndex' is logically sound based on the text provided."
                "4. The 'rationale' must explicitly explain why the correct answer is right and why others are wrong."
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
