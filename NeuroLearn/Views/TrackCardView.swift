
//
//  TrackCardView.swift
//  NeuroLearn
//

import SwiftUI

struct TrackCardView: View {
    let track: PreconfiguredTrack
    
    var body: some View {
        HStack(spacing: 16) {
            // Track Icon
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.third)
                    .frame(width: 70, height: 70)
                
                Image(systemName: track.icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35)
                    .foregroundStyle(.accent)
            }
            
            // Track Info
            VStack(alignment: .leading, spacing: 6) {
                Text(track.title)
                    .foregroundStyle(.accent)
                    .dyslexicStyle(size: 22, weight: .bold)
                
                Text(track.description)
                    .foregroundStyle(.accent.opacity(0.8))
                    .dyslexicStyle(size: 14, weight: .regular)
                    .lineLimit(2)
            }
            
            Spacer(minLength: 0)
            
            // Navigation Indicator
            Image(systemName: "chevron.right")
                .foregroundStyle(Color.second)
                .font(.title3.bold())
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
    TrackCardView(track: PreconfiguredTrack.allTracks[0])
}
