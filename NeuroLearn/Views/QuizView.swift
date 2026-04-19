import SwiftUI
import FoundationModels

enum QuizState {
    case playing, results, reviewing
}

struct QuizView: View {
    let questions: [QuizQuestion].PartiallyGenerated
    
    // State Tracking
    @State private var currentIndex = 0
    @State private var userAnswers: [Int?] = [] // Stores the index user picked for each question
    @State private var state: QuizState = .playing
    @State private var selectedIndex: Int?
    @State private var showFeedback = false
    
    var body: some View {
        VStack(spacing: 20) {
            switch state {
            case .playing:
                playingView
            case .results:
                resultsSummaryView
            case .reviewing:
                reviewModeView
            }
        }
        .padding()
        .onAppear {
            // Initialize answers array if it's empty
            if userAnswers.isEmpty {
                userAnswers = Array(repeating: nil, count: questions.count)
            }
        }
    }
    
    // --- 1. THE MAIN QUIZ VIEW ---
    var playingView: some View {
        VStack(spacing: 25) {
            ProgressView(value: Double(currentIndex + 1), total: Double(questions.count))
                .tint(.indigo)
            
            if currentIndex < questions.count {
                let q = questions[currentIndex]
                
                VStack(alignment: .leading, spacing: 20) {
                    Text(q.question ?? "Loading...").font(.title2.bold())
                    
                    if let options = q.options {
                        ForEach(Array(options.enumerated()), id: \.offset) { index, option in
                            OptionButton(
                                text: option ?? "",
                                isSelected: selectedIndex == index,
                                isCorrect: q.correctAnswerIndex == index,
                                showFeedback: showFeedback
                            ) {
                                selectOption(index)
                            }
                        }
                    }
                }
                .transition(.neuroFluid)
                
                if showFeedback {
                    feedbackFooter(for: q)
                }
            }
        }
    }

    // --- 2. THE RESULTS SUMMARY ---
    var resultsSummaryView: some View {
        VStack(spacing: 30) {
            Text("Quiz Results").font(.largeTitle.bold())
            
            let score = calculateScore()
            Text("\(score) / \(questions.count)")
                .font(.system(size: 60, weight: .black))
                .foregroundStyle(.indigo.gradient)
            
            VStack(spacing: 12) {
                Button("Retake Full Test") { resetQuiz() }
                    .buttonStyle(.borderedProminent)
                
                if score < questions.count {
                    Button("Review Incorrect Answers") {
                        state = .reviewing
                        currentIndex = 0 // Reset to start of review
                    }
                    .buttonStyle(.bordered)
                }
            }
        }
        .transition(.neuroFluid)
    }

    // --- 3. THE REVIEW MODE ---
    var reviewModeView: some View {
        VStack(spacing: 20) {
            Text("Reviewing Errors").font(.headline).foregroundStyle(.red)
            
            // Only show questions where user was wrong
            let wrongIndices = getIncorrectIndices()
            if currentIndex < wrongIndices.count {
                let qIndex = wrongIndices[currentIndex]
                let q = questions[qIndex]
                
                VStack(alignment: .leading, spacing: 15) {
                    Text(q.question ?? "").font(.title3.bold())
                    Text("Your answer: \(q.options?[userAnswers[qIndex] ?? 0] ?? "None")")
                        .foregroundStyle(.red)
                    Text("Correct answer: \(q.options?[q.correctAnswerIndex ?? 0] ?? "")")
                        .foregroundStyle(.green)
                    
                    Text(q.rationale ?? "").card()
                }
                
                Button("Next Error") {
                    if currentIndex + 1 < wrongIndices.count {
                        currentIndex += 1
                    } else {
                        state = .results
                    }
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }

    // Helpers
    func selectOption(_ index: Int) {
        withAnimation(.neuroSpring) {
            selectedIndex = index
            userAnswers[currentIndex] = index
            showFeedback = true
        }
    }
    
    func nextStep() {
        withAnimation(.neuroSpring) {
            if currentIndex + 1 < questions.count {
                currentIndex += 1
                selectedIndex = nil
                showFeedback = false
            } else {
                state = .results
            }
        }
    }
    
    func resetQuiz() {
        withAnimation(.neuroSpring) {
            currentIndex = 0
            userAnswers = Array(repeating: nil, count: questions.count)
            state = .playing
            selectedIndex = nil
            showFeedback = false
        }
    }
    
    func calculateScore() -> Int {
        var score = 0
        for i in 0..<questions.count {
            if userAnswers[i] == questions[i].correctAnswerIndex {
                score += 1
            }
        }
        return score
    }
    
    func getIncorrectIndices() -> [Int] {
        questions.indices.filter { userAnswers[$0] != questions[$0].correctAnswerIndex }
    }
    
    @ViewBuilder
    func feedbackFooter(for q: QuizQuestion.PartiallyGenerated) -> some View {
        VStack {
            Text(q.rationale ?? "").font(.subheadline).padding()
            Button("Continue") { nextStep() }
                .buttonStyle(.borderedProminent).tint(.indigo)
        }
        .transition(.move(edge: .bottom).combined(with: .opacity))
    }
}
