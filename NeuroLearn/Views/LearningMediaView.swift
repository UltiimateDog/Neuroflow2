//
//  LearningMediaView.swift
//  NeuroLearn
//
//  Created by Dev Jr. 15 on 18/04/26.
//

import SwiftUI
struct LearningMediaView: View {
    let urlString: String
    
    var body: some View {
        AsyncImage(
            url: URL(string: urlString),
            transaction: Transaction(animation: .neuroSpring) // Your custom spring
        ) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 220)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .transition(.neuroFluid) // Your custom transition
            
            case .empty:
                // Professional placeholder while loading
                ZStack {
                    RoundedRectangle(cornerRadius: 16).fill(.secondary.opacity(0.1))
                    ProgressView().tint(.indigo)
                }
                .frame(height: 220)
                
            case .failure:
                // Clean fallback if the link is broken
                Image(systemName: "photo.badge.exclamationmark")
                    .font(.largeTitle)
                    .frame(height: 220)
            @unknown default:
                EmptyView()
            }
        }
    }
}
