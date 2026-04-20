//
//  TrackNode.swift
//  NeuroLearn
//
//  Created by Dev Jr. 15 on 19/04/26.
//

//
//  TrackNodeView.swift
//  NeuroLearn
//

import SwiftUI

struct TrackNodeView: View {
    let node: TrackNode
    let index: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(node.isLocked ? Color.gray.opacity(0.2) : Color.third)
                        .frame(width: 50, height: 50)
                    
                    if node.isLocked {
                        Image(systemName: "lock.fill")
                            .font(.title2.bold())
                            .foregroundStyle(.gray)
                    } else {
                        Text("\(index)")
                            .font(.title2.bold())
                            .foregroundStyle(.accent)
                    }
                }
                
                Text(node.title)
                    .foregroundStyle(node.isLocked ? .gray : .accent)
                    .dyslexicStyle(size: 20, weight: .bold)
                
                Spacer()
                
                Image(systemName: node.icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25)
                    .bold()
                    .foregroundStyle(node.isLocked ? Color.gray.opacity(0.5) : .accent)
            }
            
            if !node.isLocked {
                VStack(alignment: .leading, spacing: 10) {
                    Text(node.explanation)
                        .foregroundStyle(.accent)
                        .dyslexicStyle()
                }
                .padding(.leading, 10)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 22)
                .fill(Color.white)
                // Use your app's signature shadow style, muted if locked
                .shadow(color: node.isLocked ? Color.clear : .second, radius: 1)
                .shadow(color: node.isLocked ? Color.gray.opacity(0.3) : .second, radius: 2)
        )
        .padding(.horizontal, 15)
        .opacity(node.isLocked ? 0.8 : 1.0)
    }
}

#Preview {
    VStack {
        TrackNodeView(node: TrackNode(title: "Basic Addition", explanation: "Combine two numbers together.", icon: "plus.circle.fill", isLocked: false, associatedLandmarkName: ""), index: 1)
        TrackNodeView(node: TrackNode(title: "Basic Subtraction", explanation: "Take one number away.", icon: "minus.circle.fill", isLocked: true, associatedLandmarkName: ""), index: 2)
    }
}
