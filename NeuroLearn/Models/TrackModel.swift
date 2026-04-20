//
//  TrackModel.swift
//  NeuroLearn
//
//  Created by Dev Jr. 15 on 19/04/26.
//

//
//  LearningTrack.swift
//  NeuroLearn
//

import Foundation

struct PreconfiguredTrack: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let nodes: [TrackNode]
}

struct TrackNode: Identifiable {
    let id = UUID()
    let title: String
    let explanation: String
    let icon: String
    let isLocked: Bool
    let associatedLandmarkName: String // Links to your LearningPlanner logic
}

// Mock Data for a TEACCH-structured Math Track
extension PreconfiguredTrack {
    static let basicMath = PreconfiguredTrack(
        title: "Basic Math",
        description: "Learn math step-by-step with clear, visual guides.",
        nodes: [
            TrackNode(title: "Number Recognition", explanation: "Learn to identify numbers from 1 to 10.", icon: "1.circle.fill", isLocked: false, associatedLandmarkName: "Numbers 1 to 10"),
            TrackNode(title: "Basic Addition", explanation: "Combine two numbers together.", icon: "plus.circle.fill", isLocked: false, associatedLandmarkName: "Addition"),
            TrackNode(title: "Basic Subtraction", explanation: "Take one number away from another.", icon: "minus.circle.fill", isLocked: true, associatedLandmarkName: "Subtraction"),
            TrackNode(title: "Simple Shapes", explanation: "Recognize squares, circles, and triangles.", icon: "square.on.circle.fill", isLocked: true, associatedLandmarkName: "Basic Shapes")
        ]
    )
}
