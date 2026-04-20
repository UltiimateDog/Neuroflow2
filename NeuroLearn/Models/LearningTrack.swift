//
//  LearningTrack.swift
//  NeuroLearn
//

import Foundation

struct PreconfiguredTrack: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let icon: String // NEW: An icon for the track's card
    let nodes: [TrackNode]
}

struct TrackNode: Identifiable {
    let id = UUID()
    let title: String
    let explanation: String
    let icon: String
    let isLocked: Bool
    let associatedLandmarkName: String
}

// Mock Data for Multiple Tracks
extension PreconfiguredTrack {
    static let allTracks: [PreconfiguredTrack] = [
        PreconfiguredTrack(
            title: "Basic Math",
            description: "Learn math step-by-step with clear, visual guides.",
            icon: "plus.forwardslash.minus",
            nodes: [
                TrackNode(title: "Number Recognition", explanation: "Learn to identify numbers from 1 to 10.", icon: "1.circle.fill", isLocked: false, associatedLandmarkName: "Numbers 1 to 10"),
                TrackNode(title: "Basic Addition", explanation: "Combine two numbers together.", icon: "plus.circle.fill", isLocked: false, associatedLandmarkName: "Addition"),
                TrackNode(title: "Basic Subtraction", explanation: "Take one number away from another.", icon: "minus.circle.fill", isLocked: true, associatedLandmarkName: "Subtraction")
            ]
        ),
        PreconfiguredTrack(
            title: "Daily Routines",
            description: "Master your morning and evening schedules.",
            icon: "sun.max.fill",
            nodes: [
                TrackNode(title: "Morning Routine", explanation: "Steps to start your day right.", icon: "sunrise.fill", isLocked: false, associatedLandmarkName: "Morning Routine"),
                TrackNode(title: "Brushing Teeth", explanation: "How to keep your smile bright.", icon: "mouth.fill", isLocked: true, associatedLandmarkName: "Brushing Teeth")
            ]
        ),
        PreconfiguredTrack(
            title: "Social Skills",
            description: "Practice saying hello, sharing, and more.",
            icon: "person.2.fill",
            nodes: [
                TrackNode(title: "Saying Hello", explanation: "How to greet people nicely.", icon: "hand.wave.fill", isLocked: false, associatedLandmarkName: "Greetings"),
                TrackNode(title: "Sharing Toys", explanation: "Taking turns with friends.", icon: "arrow.2.squarepath", isLocked: true, associatedLandmarkName: "Sharing")
            ]
        )
    ]
}
