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
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading) {
                Image(systemName: "sparkles")
                    .symbolEffect(.variableColor.iterative, options: .repeating)
                    .foregroundStyle(.indigo)
                
                Text("Researching \(landmark.name)...")
                    .font(.largeTitle.bold())
            }
            
            VStack(spacing: 12) {
                ForEach(planner.resourceTool.lookupHistory) { lookup in
                    HStack {
                        Image(systemName: "lightbulb.fill")
                            .foregroundStyle(.yellow)
                        Text("Finding a simple **\(lookup.type.rawValue)**...")
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    // Use the safe custom transition we just built
                    .transition(.neuroFluid)
                }
            }
            .animation(.neuroSpring, value: planner.resourceTool.lookupHistory.count)
        }
        .padding()
        .padding(.top, 120)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
