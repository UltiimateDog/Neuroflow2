//
//  ItineraryPlanningView.swift
//  NeuroLearn
//
//  Created by Dev Jr. 15 on 18/04/26.
//

import SwiftUI

struct LearningPlanningView: View {
    
    let landmark: Landmark
    let planner: LearningPlanner
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 15) {
            Spacer()
            
            middle()
            
            VStack(spacing: 12) {
                ForEach(planner.resourceTool.lookupHistory) { lookup in
                    
                    SubjectBox(title: try! AttributedString(markdown:"Finding a simple **\(lookup.type.rawValue)**..."), icon: "lightbulb.fill")
                        .transition(.neuroFluid)
                    
                }
            }
            .animation(.neuroSpring, value: planner.resourceTool.lookupHistory.count)
            
            Spacer()
        }
        .background(Color.third.opacity(0.4).ignoresSafeArea())
        
    }
    
    // MARK: - Middle
    @ViewBuilder
    private func middle() -> some View {
        ZStack {
            
            Image(systemName: "brain.fill")
                .resizable()
                .scaledToFit()
                .frame(height: 60)
                .gradientForeground(
                    colors: [.second, .accent],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .shimmer(isActive: true)
            
            BrainThinkingAnimation(innerRadius: 35)
            
        }
        .offset(y: 25)
        
        HStack {
            
            Spacer()
            
            Text("Researching \(landmark.name)...")
                .font(.largeTitle)
                .fontDesign(.rounded)
                .fontWeight(.bold)
                .foregroundStyle(.accent)
                .lineLimit(1)
                .shimmer(isActive: true)
            
            Spacer()
            
        }
    }
}

#Preview {
    let landmark: Landmark = .virtual(name: "Test")
    
    LearningPlanningView(landmark: landmark, planner: LearningPlanner(subject: landmark.name))
}
