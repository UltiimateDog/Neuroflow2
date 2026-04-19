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
                HStack {
                    Spacer()
                    
                    quizInterface
                    
                    Spacer()
                }
            case .results:
                HStack {
                    Spacer()
                    
                    resultsView
                    
                    Spacer()
                }
            case .reviewing:
                HStack {
                    Spacer()
                    
                    reviewMode
                    
                    Spacer()
                }
            }
        }
        .background(Color.third.opacity(0.4).ignoresSafeArea())
        .onAppear {
            if userAnswers.isEmpty {
                userAnswers = Array(repeating: nil, count: questions.count)
            }
        }
    }
    
    // --- QUIZ GAME ---
    var quizInterface: some View {
        VStack(spacing: 25) {
            
            Spacer()
            
            // Header
            Text("Knowledge Check")
                .foregroundStyle(.accent)
                .dyslexicStyle(size: 28, weight: .bold)
            
            // Progress (TEACCH style)
            QuizProgressIndicator(
                total: questions.count,
                current: currentIndex
            )
                .padding(.horizontal)
            
            if currentIndex < questions.count {
                let q = questions[currentIndex]
                
                VStack(alignment: .leading, spacing: 20) {
                    
                    Text(q.question ?? "Loading question...")
                        .foregroundStyle(.accent)
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
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 22)
                        .fill(Color.white)
                        .shadow(color: .second, radius: 1)
                        .shadow(color: .second, radius: 2)
                )
                .padding(.horizontal)
                .transition(.neuroFluid)
                
                if showFeedback {
                    VStack(spacing: 16) {
                        
                        Text(q.rationale ?? "")
                            .foregroundStyle(.accent)
                            .dyslexicStyle(size: 16)
                            .padding()
                            .background(Color.third)
                            .cornerRadius(12)
                            .padding(.horizontal)
                        
                        Button("Next Question") { nextQuestion() }
                            .buttonStyle(.borderedProminent)
                            .tint(.accent)
                            .controlSize(.large)
                    }
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
            
            Spacer()

        }
    }

    // --- RESULTS ---
    var resultsView: some View {
        VStack(spacing: 30) {
            
            Spacer()

            
            Text("Routine Complete!")
                .foregroundStyle(.accent)
                .dyslexicStyle(size: 30, weight: .bold)
            
            let score = calculateScore()
            
            Text("\(score) / \(questions.count)")
                .font(.system(size: 70, weight: .black, design: .rounded))
                .foregroundStyle(
                    LinearGradient(
                        colors: [.second, .accent],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            
            VStack(spacing: 15) {
                
                Button("Retake Full Quiz") { resetQuiz() }
                    .buttonStyle(.borderedProminent)
                    .tint(.accent)
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
            
            Spacer()

        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 22)
                .fill(Color.white)
                .shadow(color: .second, radius: 1)
                .shadow(color: .second, radius: 2)
        )
        .padding()
    }

    // --- REVIEW MODE ---
    var reviewMode: some View {
        VStack(spacing: 20) {
            
            Spacer()

            
            let incorrectIndices = getIncorrectIndices()
            
            if currentIndex < incorrectIndices.count {
                let qIndex = incorrectIndices[currentIndex]
                let q = questions[qIndex]
                
                Text("Reviewing Error \(currentIndex + 1) of \(incorrectIndices.count)")
                    .foregroundStyle(.red)
                    .dyslexicStyle(weight: .bold)
                
                VStack(alignment: .leading, spacing: 15) {
                    
                    Text(q.question ?? "")
                        .foregroundStyle(.accent)
                        .dyslexicStyle(size: 20, weight: .bold)
                    
                    Text("Correct Answer: \(q.options?[q.correctAnswerIndex ?? 0] ?? "")")
                        .foregroundStyle(.green)
                        .dyslexicStyle()
                    
                    Text(q.rationale ?? "")
                        .foregroundStyle(.accent)
                        .dyslexicStyle(size: 16)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 22)
                        .fill(Color.white)
                        .shadow(color: .second, radius: 1)
                        .shadow(color: .second, radius: 2)
                )
                .padding(.horizontal)
                
                Button("Continue Review") {
                    if currentIndex + 1 < incorrectIndices.count {
                        currentIndex += 1
                    } else {
                        state = .results
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(.accent)
            }
            
            Spacer()

        }
    }

    // --- LOGIC ---
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


// --- OPTION BUTTON (MATCHED STYLE) ---
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
                    .foregroundStyle(.accent)
                    .dyslexicStyle(weight: isSelected ? .bold : .medium)
                
                Spacer()
                
                if showFeedback {
                    Image(systemName: isCorrect ? "checkmark.circle.fill" : (isSelected ? "xmark.circle.fill" : "circle"))
                        .foregroundStyle(isCorrect ? .green : (isSelected ? .red : .secondary))
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color.white)
                    .shadow(color: .second, radius: 1)
                    .shadow(color: .second, radius: 2)
            )
        }
        .disabled(showFeedback)
    }
}

struct QuizProgressIndicator: View {
    let total: Int
    let current: Int   // zero-based index
    
    var body: some View {
        HStack(spacing: 6) {
            ForEach(0..<total, id: \.self) { index in
                RoundedRectangle(cornerRadius: 4)
                    .fill(fillColor(for: index))
                    .frame(height: 8)
                    .animation(.neuroSpring, value: current)
            }
        }
        .padding(.horizontal)
    }
    
    private func fillColor(for index: Int) -> Color {
        if index < current {
            return .accent            // completed
        } else if index == current {
            return .second            // current step (slightly different highlight)
        } else {
            return Color.third        // remaining
        }
    }
}
