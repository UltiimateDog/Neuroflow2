import FoundationModels
import SwiftUI

struct LearningView: View {
    let plan: LearningPlan.PartiallyGenerated

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Header Section
                VStack(alignment: .leading, spacing: 8) {
                    if let topic = plan.topic {
                        Text(topic)
                            .font(.largeTitle.bold())
                    }
                    
                    // Image Section
                                    if let urlString = plan.mediaURL {
                                        // This only shows if the AI successfully called the tool
                                        LearningMediaView(urlString: urlString)
                                    } else {
                                        // Placeholder so you know the AI hasn't found an image yet
                                        RoundedRectangle(cornerRadius: 16)
                                            .fill(.secondary.opacity(0.1))
                                            .frame(height: 200)
                                            .overlay {
                                                Label("Searching for visual media...", systemImage: "photo")
                                                    .foregroundStyle(.secondary)
                                            }
                                    }
                    if let overview = plan.simpleOverview {
                        Text(overview)
                            .font(.body)
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(12)
                    }
                }
                
                // Learning Steps Section
                if let steps = plan.steps {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Step-by-Step Guide").font(.title2.bold())
                        
                        ForEach(steps) { step in
                            VStack(alignment: .leading, spacing: 8) {
                                Text(step.title ?? "").font(.headline)
                                Text(step.explanation ?? "").font(.body)
                                
                                if let takeaway = step.keyTakeaway {
                                    Text("Key Takeaway: \(takeaway)")
                                        .font(.caption.bold())
                                        .foregroundStyle(.indigo)
                                        .padding(.top, 4)
                                }
                            }
                            .card() // Using the professional card style from Utils
                            .transition(.neuroFluid)
                        }
                    }
                }

                // --- NEW: Flashcards Section ---
                if let flashcards = plan.flashcards {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Review Flashcards").font(.title2.bold())
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                ForEach(flashcards) { card in
                                    FlashcardView(card: card)
                                        .transition(.neuroFluid)
                                }
                            }
                            .padding(.vertical, 10)
                            .padding(.horizontal, 5)
                        }
                    }
                }
            }
            .padding()
        }
        .animation(.neuroSpring, value: plan) // Professional spring from Utils
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
