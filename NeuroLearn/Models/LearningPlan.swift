import Foundation
import FoundationModels


@Generable
struct LearningPlan: Equatable {
    let topic: String
    let simpleOverview: String
    let rationale: String
    let steps: [LearningStep]
    let flashcards: [Flashcard]
    let mediaURL: String?
    let chartData: [ChartElement]?
    // NEW: The quiz questions for the second tab
    let quizQuestions: [QuizQuestion]
}

@Generable
struct QuizQuestion: Equatable, Identifiable {
    var id: String { question }
    let question: String
    let options: [String]
    let correctAnswerIndex: Int
    let rationale: String // Explain why the answer is correct
}
@Generable
struct LearningStep: Equatable, Identifiable {
    var id: String { title }
    let title: String
    let explanation: String
    let keyTakeaway: String
    let visualHint: String
}

@Generable
struct Flashcard: Equatable, Identifiable {
    var id: String { question }
    let question: String
    let answer: String
}

@Generable
struct ChartElement: Equatable, Identifiable {
    var id: String { label }
    let label: String
    let value: Double
}
