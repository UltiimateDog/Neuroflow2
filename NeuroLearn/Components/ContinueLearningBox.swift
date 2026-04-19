//
//  ContinueLearningBox.swift
//  NeuroFlow
//
//  Created by Ultiimate Dog on 18/04/26.
//

import SwiftUI

struct ContinueLearningBox: View {
    let title: String
    let icon: String
    let progress: Double
    let subtitle: String
    
    var body: some View {
        HStack(spacing: 15) {
            
            // Icon
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.third)
                    .frame(width: 90, height: 90)
                
                Image(systemName: icon)
                    .font(.system(size: 40, weight: .semibold))
                    .foregroundStyle(.accent)
            }
            
            VStack(alignment: .leading, spacing: 10) {
                
                // Title
                Text(title)
                    .font(.title3)
                    .fontDesign(.rounded)
                    .fontWeight(.bold)
                    .foregroundStyle(.accent)
                
                // Percentage
                Text("\(Int(progress * 100))% completed")
                    .font(.footnote)
                    .fontDesign(.rounded)
                    .foregroundStyle(.second)
                    .bold()
                
                // Progress bar
                ProgressView(value: progress)
                    .tint(.accent)
                    .scaleEffect(x: 1, y: 2.2)
                
                HStack {
                    Spacer()
                    
                    Text(subtitle)
                        .font(.footnote)
                        .fontDesign(.rounded)
                        .foregroundStyle(.second)
                        .bold()
                        .lineLimit(1)
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
        .padding(.horizontal, 15)
    }
}
#Preview {
    ContinueLearningBox(title: "Test", icon: "hearth", progress: 0.4, subtitle: "Test")
}
