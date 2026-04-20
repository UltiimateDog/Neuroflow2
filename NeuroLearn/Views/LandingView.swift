//
//  LandingView.swift
//  NeuroLearn
//
//  Created by Ultiimate Dog on 20/04/26.
//

import SwiftUI

struct LandingView: View {
    
    @State private var enterApp = false
    
    @State private var selectedTab = 1
    
    var body: some View {
        if !enterApp {
            VStack(spacing: 45) {
                
                Spacer()
                
                // MARK: - Logo / Identity
                VStack(spacing: 10) {
                    Image(systemName: "brain.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 80)
                        .gradientForeground(
                            colors: [.second, .accent],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    
                    Text("NeuroFlow AI")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .fontDesign(.rounded)
                        .kerning(1)
                        .gradientForeground(
                            colors: [.second, .accent],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    
                    Text("Learn the way your brain needs")
                        .font(.headline)
                        .fontDesign(.rounded)
                        .foregroundStyle(.second)
                        .dyslexicStyle()
                    
                }
                
                // MARK: - Value Proposition
                VStack(spacing: 30) {
                    
                    FeatureRow(
                        icon: "sparkles",
                        title: "Personalized Learning",
                        description: "AI builds structured lessons tailored to your topic and pace."
                    )
                    
                    FeatureRow(
                        icon: "brain.fill",
                        title: "Neuro-Adaptive Design",
                        description: "Built for focus, clarity, and cognitive flow."
                    )
                    
                    FeatureRow(
                        icon: "checkmark.circle.fill",
                        title: "Active Recall",
                        description: "Quizzes and flashcards reinforce what you learn."
                    )
                    
                }
                .padding(.horizontal)
                
                Spacer()
                
                // MARK: - CTA Button
                Button {
                    withAnimation {
                        enterApp = true
                    }
                } label: {
                    Text("Start Learning")
                        .font(.headline)
                        .fontDesign(.rounded)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(
                            RoundedRectangle(cornerRadius: 18)
                                .fill(
                                    LinearGradient(
                                        colors: [.second, .accent],
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )
                        )
                        .padding(.horizontal)
                }
                
                Spacer()
            }
            .background(Color.third.opacity(0.4).ignoresSafeArea())
        } else {
            TabView(selection: $selectedTab) {
                
                TrackHomeView()
                    .tabItem {
                        Label("Tracks", systemImage: "target")
                    }
                    .tag(0)
                
                ChatHomeView()
                    .tabItem {
                        Label("Chat", systemImage: "bubble.left.and.text.bubble.right")
                    }
                    .tag(1) // this will be the default
                
                HistoryHomeView()
                    .tabItem {
                        Label("History", systemImage: "book.fill")
                    }
                    .tag(2)
            }
            .transition(.move(edge: .trailing))
        }
        
    }
}


// MARK: - Feature Row Component
struct FeatureRow: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 28, height: 28)
                .gradientForeground(
                    colors: [.second, .accent],
                    startPoint: .top,
                    endPoint: .bottom
                )
            
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.headline)
                    .fontDesign(.rounded)
                    .foregroundStyle(.accent)
                    .dyslexicStyle(weight: .bold)

                
                Text(description)
                    .font(.subheadline)
                    .fontDesign(.rounded)
                    .foregroundStyle(.second)
                    .dyslexicStyle(weight: .semibold)

            }
            
            Spacer()
        }
    }
}


// MARK: - Preview
#Preview {
    LandingView()
}
