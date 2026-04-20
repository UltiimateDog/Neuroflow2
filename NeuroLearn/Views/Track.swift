//
//  TrackView.swift
//  NeuroLearn
//

import SwiftUI

struct TrackView: View {
    let track: PreconfiguredTrack
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                
                // Header
                VStack(spacing: 8) {
                    Text(track.title)
                        .font(.largeTitle.bold())
                        .foregroundStyle(.accent)
                    
                    Text(track.description)
                        .foregroundStyle(.accent)
                        .dyslexicStyle()
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                .padding(.vertical, 30)
                
                // Track Path
                ForEach(Array(track.nodes.enumerated()), id: \.element.id) { index, node in
                    
                    if node.isLocked {
                        TrackNodeView(node: node, index: index + 1)
                    } else {
                        // Link to your existing learning logic!
                        NavigationLink(destination: LearningTripView(landmark: .virtual(name: node.associatedLandmarkName))) {
                            TrackNodeView(node: node, index: index + 1)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    // Connecting line (Visual Schedule for TEACCH methodology)
                    if index < track.nodes.count - 1 {
                        Rectangle()
                            .fill(track.nodes[index + 1].isLocked ? Color.gray.opacity(0.3) : Color.second)
                            .frame(width: 6, height: 40)
                            .cornerRadius(3)
                            .padding(.vertical, 4)
                    }
                }
            }
            .padding(.bottom, 50)
        }
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
        .navigationTitle("Track")
        .navigationBarTitleDisplayMode(.inline)
    }
}


//
//  TrackHomeView.swift
//  NeuroLearn
//

import SwiftUI

struct TrackHomeView: View {
    let tracks = PreconfiguredTrack.allTracks
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    // Header Section
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Learning Tracks")
                            .font(.largeTitle.bold())
                            .foregroundStyle(.accent)
                        
                        Text("Choose a subject to start learning step-by-step.")
                            .foregroundStyle(.accent)
                            .dyslexicStyle(size: 16, weight: .regular)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    
                    // List of Tracks
                    VStack(spacing: 16) {
                        ForEach(tracks) { track in
                            NavigationLink(destination: TrackView(track: track)) {
                                TrackCardView(track: track)
                            }
                            // Prevents the NavigationLink from overriding text colors
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.bottom, 30)
                }
            }
            .background(Color(.systemGroupedBackground).ignoresSafeArea())
            // Ensures the navigation bar is styled nicely when pushed
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    TrackHomeView()
}
