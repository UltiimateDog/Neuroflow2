import FoundationModels
import SwiftUI

import SwiftUI
import FoundationModels

struct LearningView: View {
    let plan: LearningPlan.PartiallyGenerated
    @State private var speech = SpeechManager()
    
    @Namespace private var namespace

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 35) {
                // 1. Header & Speech Toggle
                HStack(alignment: .firstTextBaseline) {
                    if let topic = plan.topic {
                        Text(topic)
                            .foregroundStyle(.accent)
                            .dyslexicStyle(size: 34, weight: .bold)
                    }
                    Spacer()
                    
                    Button {
                        withAnimation {
                            speech.isSpeaking ? speech.stop() : speech.speak(plan.simpleOverview ?? "")
                        }
                    } label: {
                        ZStack {
                            if speech.isSpeaking {
                                Image(systemName: "speaker.wave.2.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40)
                                    .bold()
                                    .gradientForeground(
                                        colors: [.second, .accent],
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                    .symbolEffect(.variableColor)
                                    .matchedGeometryEffect(id: "speaker", in: namespace)
                                
                            } else {
                                Image(systemName: "speaker.wave.2.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 35)
                                    .bold()
                                    .gradientForeground(
                                        colors: [.second, .accent],
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                    .matchedGeometryEffect(id: "speaker", in: namespace)
                            }
                        }
                        .frame(width: 35)
                        .animation(.neuroSpring, value: speech.isSpeaking)
                    }
                    .padding(.trailing, 5)
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
                            
                            LearningStepBox(
                                index: index + 1,
                                title: step.title ?? "",
                                explanation: step.explanation ?? "",
                                takeaway: step.keyTakeaway ?? ""
                            )
                            .transition(.neuroFluid)
                            
                        }
                    }
                }
                
                // 4. Flashcards (Visual Review)
                if let flashcards = plan.flashcards {
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Review Tools")
                            .foregroundStyle(.accent)
                            .dyslexicStyle(size: 24, weight: .bold)
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                ForEach(flashcards) { card in
                                    FlashcardView(card: card)
                                }
                            }
                            .padding()
                        }
                        .scrollIndicators(.hidden)

                    }
                }//: If
            }
            .padding(.vertical)
        }
        .scrollIndicators(.hidden)
        .background(Color.third.opacity(0.4).ignoresSafeArea())
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
                    .fill(.accent)
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
            CardFace(text: card.question ?? "Generating question...", isFaceUp: true)
                .opacity(isFlipped ? 0 : 1)
            
            // Back of Card
            CardFace(text: card.answer ?? "Generating answer...", isFaceUp: false)
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
            .foregroundStyle(.accent)
            .dyslexicStyle(weight: isFaceUp ? .semibold : .bold)
            .padding()
            .frame(width: 260, height: 180)
            .background(
                RoundedRectangle(cornerRadius: 22)
                    .fill(Color.white)
                    .shadow(color: .second, radius: 1)
                    .shadow(color: .second, radius: 2)
            )
    }
}
