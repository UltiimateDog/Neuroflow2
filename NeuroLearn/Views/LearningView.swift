import FoundationModels
import SwiftUI

import SwiftUI
import FoundationModels

struct LearningView: View {
    let plan: LearningPlan.PartiallyGenerated
    @State private var speech = SpeechManager()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 35) {
                // 1. Header & Speech Toggle
                HStack(alignment: .firstTextBaseline) {
                    if let topic = plan.topic {
                        Text(topic)
                            .dyslexicStyle(size: 34, weight: .bold)
                    }
                    Spacer()
                    Button {
                        speech.isSpeaking ? speech.stop() : speech.speak(plan.simpleOverview ?? "")
                    } label: {
                        Image(systemName: speech.isSpeaking ? "speaker.wave.3.fill" : "speaker.wave.2")
                            .font(.title2)
                            .padding(12)
                            .background(.indigo.opacity(0.1))
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal)

                // 2. The "Visual Schedule" (Progress Tracker)
                if let steps = plan.steps {
                    TEACCHProgressIndicator(count: steps.count)
                }

                // 3. Structured Content Steps
                if let steps = plan.steps {
                    VStack(alignment: .leading, spacing: 24) {
                        ForEach(Array(steps.enumerated()), id: \.offset) { index, step in
                            VStack(alignment: .leading, spacing: 15) {
                                HStack {
                                    Text("\(index + 1)")
                                        .font(.system(.headline, design: .rounded))
                                        .foregroundColor(.white)
                                        .frame(width: 30, height: 30)
                                        .background(.indigo)
                                        .clipShape(Circle())
                                    
                                    Text(step.title ?? "")
                                        .dyslexicStyle(size: 22, weight: .bold)
                                }
                                
                                Text(step.explanation ?? "")
                                    .dyslexicStyle()
                                
                                // Call to Action / Key Point
                                HStack {
                                    Image(systemName: "star.fill").foregroundColor(.orange)
                                    Text(step.keyTakeaway ?? "").dyslexicStyle(size: 16, weight: .bold)
                                }
                                .padding()
                                .background(.orange.opacity(0.1))
                                .cornerRadius(12)
                                
                                Button("Listen to Step \(index + 1)") {
                                    speech.speak(step.explanation ?? "")
                                }
                                .font(.system(.subheadline, design: .rounded).bold())
                                .foregroundColor(.indigo)
                            }
                            .teacchCard()
                            .transition(.neuroFluid)
                        }
                    }
                }
                
                // 4. Flashcards (Visual Review)
                if let flashcards = plan.flashcards {
                    Text("Review Tools").dyslexicStyle(size: 24, weight: .bold).padding(.horizontal)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(flashcards) { card in
                                FlashcardView(card: card)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .padding(.vertical)
        }
        .animation(.neuroSpring, value: plan)
    }
}

// TEACCH Element: Tells the user exactly how much work is left
struct TEACCHProgressIndicator: View {
    let count: Int
    var body: some View {
        HStack {
            ForEach(0..<count, id: \.self) { _ in
                RoundedRectangle(cornerRadius: 4)
                    .fill(.indigo.opacity(0.3))
                    .frame(height: 8)
            }
        }
        .padding(.horizontal)
    }
}

struct FlashcardView: View {
    let card: Flashcard.PartiallyGenerated
    @State private var degree: Double = 0
    @State private var isFlipped = false

    var body: some View {
        ZStack {
            // Front of Card
            CardFace(text: card.question ?? "Generating question...", isFaceUp: !isFlipped)
                .opacity(isFlipped ? 0 : 1)
            
            // Back of Card
            CardFace(text: card.answer ?? "Generating answer...", isFaceUp: isFlipped)
                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                .opacity(isFlipped ? 1 : 0)
        }
        .rotation3DEffect(.degrees(degree), axis: (x: 0, y: 1, z: 0))
        .onTapGesture {
            withAnimation(.neuroSpring) {
                isFlipped.toggle()
                degree += 180
            }
        }
    }
}

struct CardFace: View {
    let text: String
    let isFaceUp: Bool
    
    var body: some View {
        Text(text)
            .font(.headline)
            .multilineTextAlignment(.center)
            .padding()
            .frame(width: 260, height: 180)
            .background(isFaceUp ? Color(.tertiarySystemBackground) : Color.indigo.opacity(0.1))
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(isFaceUp ? Color.clear : Color.indigo, lineWidth: 2)
            )
            .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}
