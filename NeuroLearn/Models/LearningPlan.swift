//
//  LearningPlan.swift
//  NeuroLearn
//

import Foundation
import FoundationModels

@Generable
struct LearningPlan: Equatable, Codable, Identifiable { // Added Codable and Identifiable
    var id = UUID() // Added ID for lists
    let topic: String
    let simpleOverview: String
    let rationale: String
    let steps: [LearningStep]
    let flashcards: [Flashcard]
    let mediaURL: String?
    let chartData: [ChartElement]?
    let quizQuestions: [QuizQuestion]
}

@Generable
struct QuizQuestion: Equatable, Identifiable, Codable { // Added Codable
    var id: String { question }
    let question: String
    let options: [String]
    let correctAnswerIndex: Int
    let rationale: String
}

@Generable
struct LearningStep: Equatable, Identifiable, Codable { // Added Codable
    var id: String { title }
    let title: String
    let explanation: String
    let keyTakeaway: String
    let visualHint: String
}

@Generable
struct Flashcard: Equatable, Identifiable, Codable { // Added Codable
    var id: String { question }
    let question: String
    let answer: String
}

@Generable
struct ChartElement: Equatable, Identifiable, Codable { // Added Codable
    var id: String { label }
    let label: String
    let value: Double
}
