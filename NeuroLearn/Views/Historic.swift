//
//  Historic.swift
//  NeuroLearn
//
//  Created by Dev Jr. 15 on 19/04/26.
//

//
//  Historic.swift
//  NeuroLearn
//

import SwiftUI

struct HistoryHomeView: View {
    var history = HistoryManager.shared
    
    var body: some View {
        NavigationStack {
            List(history.savedPlans) { plan in
                NavigationLink(destination: SavedTripDetailView(plan: plan)) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(plan.topic)
                            .font(.headline)
                            .foregroundStyle(.accent)
                            .dyslexicStyle(size: 18, weight: .bold)
                        
                        Text(plan.simpleOverview)
                            .font(.subheadline)
                            .foregroundStyle(.accent.opacity(0.8))
                            .lineLimit(2)
                            
                    }
                    .padding(.vertical, 8)
                }
            }
            .overlay {
                if history.savedPlans.isEmpty {
                    Text("No past learning trips yet!\nAsk a question to start.")
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.second)
                        
                }
            }
            .background(Color.third.opacity(0.4).ignoresSafeArea())

        }
    }
}

// MARK: - Parent Detail View
struct SavedTripDetailView: View {
    let plan: LearningPlan
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            // Using the new Completed views that accept the full plan
            CompletedLearningView(plan: plan)
                .tabItem { Label("Learn", systemImage: "book.fill") }
                .tag(0)
            
            CompletedQuizView(questions: plan.quizQuestions)
                .tabItem { Label("Quiz", systemImage: "checkmark.circle.fill") }
                .tag(1)
        }
        .tint(.accent)
        .navigationTitle(plan.topic)
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Completed Learning View
struct CompletedLearningView: View {
    let plan: LearningPlan
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Header
                VStack(spacing: 12) {
                    Text(plan.simpleOverview)
                        .foregroundStyle(.accent)
                        .dyslexicStyle(size: 18, weight: .regular)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Text(plan.rationale)
                        .foregroundStyle(.accent.opacity(0.8))
                        .dyslexicStyle(size: 14, weight: .regular)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                .padding(.top, 20)
                
                // Reusing your exact LearningStepBox directly!
                ForEach(Array(plan.steps.enumerated()), id: \.element.id) { index, step in
                    LearningStepBox(
                        index: index + 1,
                        title: step.title,
                        explanation: step.explanation,
                        takeaway: step.keyTakeaway
                    )
                }
            }
            .padding(.bottom, 40)
        }
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
    }
}

// MARK: - Completed Quiz View (Review Mode)
struct CompletedQuizView: View {
    let questions: [QuizQuestion]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                ForEach(Array(questions.enumerated()), id: \.element.id) { index, question in
                    VStack(alignment: .leading, spacing: 12) {
                        
                        // Question Title
                        Text("\(index + 1). \(question.question)")
                            .font(.headline)
                            .foregroundStyle(.accent)
                            .dyslexicStyle(size: 18, weight: .bold)
                        
                        // Options (Highlighting the correct one)
                        ForEach(Array(question.options.enumerated()), id: \.offset) { optIndex, option in
                            HStack {
                                Text(option)
                                    .foregroundStyle(optIndex == question.correctAnswerIndex ? Color.white : .accent)
                                    .dyslexicStyle(size: 16, weight: .regular)
                                
                                Spacer()
                                
                                if optIndex == question.correctAnswerIndex {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundStyle(Color.white)
                                }
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    // Green for correct, white for others
                                    .fill(optIndex == question.correctAnswerIndex ? Color.green.opacity(0.8) : Color.white)
                                    .shadow(color: .second, radius: 1)
                                    .shadow(color: .second, radius: 2)
                            )
                        }
                        
                        // Rationale Box
                        HStack(alignment: .top) {
                            Image(systemName: "info.circle.fill")
                                .foregroundStyle(Color.second)
                            Text(question.rationale)
                                .foregroundStyle(.accent)
                                .dyslexicStyle(size: 14, weight: .regular)
                        }
                        .padding()
                        .background(Color.third.opacity(0.5))
                        .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                }
            }
            .padding(.vertical)
        }
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
    }
}


#Preview {
    HistoryHomeView()
}

