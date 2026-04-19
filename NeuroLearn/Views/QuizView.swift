import SwiftUI
import FoundationModels

enum QuizState {
    case playing, results, reviewing
}

struct QuizView: View {
    let questions: [QuizQuestion].PartiallyGenerated
    
    @State private var state: QuizState = .playing
    @State private var currentIndex = 0
    @State private var userAnswers: [Int?] = []
    @State private var selectedIndex: Int?
    @State private var showFeedback = false
    
    var body: some View {
        VStack {
            switch state {
            case .playing:
                quizInterface
            case .results:
                resultsView
            case .reviewing:
                reviewMode
            }
        }
        .padding()
        .onAppear {
            if userAnswers.isEmpty {
                userAnswers = Array(repeating: nil, count: questions.count)
            }
        }
    }
    
    // --- PART 1: THE QUIZ GAME ---
    var quizInterface: some View {
        VStack(spacing: 25) {
            Text("Knowledge Check")
                .dyslexicStyle(size: 24, weight: .bold)
            
            ProgressView(value: Double(currentIndex + 1), total: Double(questions.count))
                .tint(.indigo)
            
            if currentIndex < questions.count {
                let q = questions[currentIndex]
                
                VStack(alignment: .leading, spacing: 20) {
                    Text(q.question ?? "Loading question...")
                        .dyslexicStyle(size: 22, weight: .bold)
                    
                    VStack(spacing: 12) {
                        if let options = q.options {
                            ForEach(Array(options.enumerated()), id: \.offset) { idx, text in
                                OptionButton(
                                    text: text,
                                    isSelected: selectedIndex == idx,
                                    isCorrect: q.correctAnswerIndex == idx,
                                    showFeedback: showFeedback
                                ) {
                                    handleSelection(idx)
                                }
                            }
                        }
                    }
                }
                .transition(.neuroFluid)
                
                if showFeedback {
                    VStack(spacing: 16) {
                        Text(q.rationale ?? "")
                            .dyslexicStyle(size: 16)
                            .teacchCard(color: .indigo.opacity(0.05))
                        
                        Button("Next Question") { nextQuestion() }
                            .buttonStyle(.borderedProminent)
                            .tint(.indigo)
                            .controlSize(.large)
                    }
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
        }
    }

    // --- PART 2: THE SCORE SUMMARY ---
    var resultsView: some View {
        VStack(spacing: 30) {
            Text("Routine Complete!")
                .dyslexicStyle(size: 32, weight: .bold)
            
            let score = calculateScore()
            Text("\(score) / \(questions.count)")
                .font(.system(size: 80, weight: .black, design: .rounded))
                .foregroundStyle(.indigo.gradient)
            
            VStack(spacing: 15) {
                Button("Retake Full Quiz") { resetQuiz() }
                    .buttonStyle(.borderedProminent)
                    .tint(.indigo)
                    .controlSize(.large)
                
                if score < questions.count {
                    Button("Review Mistakes") {
                        currentIndex = 0
                        state = .reviewing
                    }
                    .buttonStyle(.bordered)
                    .controlSize(.large)
                }
            }
        }
    }

    // --- PART 3: REVIEWING INCORRECT ANSWERS ---
    var reviewMode: some View {
        VStack(spacing: 20) {
            let incorrectIndices = getIncorrectIndices()
            
            if currentIndex < incorrectIndices.count {
                let qIndex = incorrectIndices[currentIndex]
                let q = questions[qIndex]
                
                Text("Reviewing Error \(currentIndex + 1) of \(incorrectIndices.count)")
                    .dyslexicStyle(weight: .bold)
                    .foregroundStyle(.red)
                
                VStack(alignment: .leading, spacing: 15) {
                    Text(q.question ?? "")
                        .dyslexicStyle(size: 20, weight: .bold)
                    
                    Text("Correct Answer: \(q.options?[q.correctAnswerIndex ?? 0] ?? "")")
                        .dyslexicStyle()
                        .foregroundColor(.green)
                    
                    Text(q.rationale ?? "")
                        .dyslexicStyle(size: 16)
                }
                .teacchCard()
                
                Button("Continue Review") {
                    if currentIndex + 1 < incorrectIndices.count {
                        currentIndex += 1
                    } else {
                        state = .results
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(.indigo)
            }
        }
    }

    // --- LOGIC HELPERS ---
    private func handleSelection(_ index: Int) {
        withAnimation(.neuroSpring) {
            selectedIndex = index
            userAnswers[currentIndex] = index
            showFeedback = true
        }
    }
    
    private func nextQuestion() {
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
    
    private func resetQuiz() {
        withAnimation(.neuroSpring) {
            currentIndex = 0
            userAnswers = Array(repeating: nil, count: questions.count)
            selectedIndex = nil
            showFeedback = false
            state = .playing
        }
    }
    
    private func calculateScore() -> Int {
        questions.indices.filter { userAnswers[$0] == questions[$0].correctAnswerIndex }.count
    }
    
    private func getIncorrectIndices() -> [Int] {
        questions.indices.filter { userAnswers[$0] != questions[$0].correctAnswerIndex }
    }
}

// --- MISSING COMPONENT: OPTION BUTTON ---
struct OptionButton: View {
    let text: String
    let isSelected: Bool
    let isCorrect: Bool
    let showFeedback: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(text)
                    .dyslexicStyle(weight: isSelected ? .bold : .medium)
                Spacer()
                if showFeedback {
                    Image(systemName: isCorrect ? "checkmark.circle.fill" : (isSelected ? "xmark.circle.fill" : "circle"))
                        .foregroundStyle(isCorrect ? .green : (isSelected ? .red : .secondary))
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(backgroundColor)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(borderColor, lineWidth: 2)
            )
            .foregroundColor(.primary)
        }
        .disabled(showFeedback)
    }
    
    private var backgroundColor: Color {
        if !showFeedback {
            return isSelected ? .indigo.opacity(0.1) : Color(.secondarySystemBackground)
        }
        if isCorrect { return .green.opacity(0.15) }
        if isSelected && !isCorrect { return .red.opacity(0.15) }
        return Color(.secondarySystemBackground)
    }
    
    private var borderColor: Color {
        if !showFeedback {
            return isSelected ? .indigo : .clear
        }
        if isCorrect { return .green }
        if isSelected && !isCorrect { return .red }
        return .clear
    }
}

#Preview {
    QuizView(questions: [])
}

