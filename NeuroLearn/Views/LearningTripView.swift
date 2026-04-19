import SwiftUI

struct LearningTripView: View {
    let landmark: Landmark
    
    @State private var planner: LearningPlanner?
    @State private var selectedTab = 0

    // MARK: - Body
    var body: some View {
        ZStack {
            if let planner = planner {
                if let plan = planner.plan {
                    TabView(selection: $selectedTab) {
                        // Tab 1: Learning Content
                        LearningView(plan: plan)
                            .tabItem { Label("Learn", systemImage: "book.fill") }
                            .tag(0)
                        
                        // Tab 2: Duolingo-style Quiz
                        if let questions = plan.quizQuestions {
                            QuizView(questions: questions)
                                .tabItem { Label("Quiz", systemImage: "checkmark.circle.fill") }
                                .tag(1)
                        }
                    }
                    .tint(.accent)
                    .transition(.opacity)
                } else {
                    LearningPlanningView(landmark: landmark, planner: planner)
                        .transition(.neuroFluid)
                }
            }
        }
        .animation(.neuroSpring, value: planner?.plan != nil)
        .task {
            planner = LearningPlanner(subject: landmark.name)
            try? await planner?.generateLearningPlan(for: landmark.name)
        }
    }
}

#Preview {
    LearningTripView(landmark: .virtual(name: "Addition"))
}
