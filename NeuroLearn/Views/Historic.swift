//
//  Historic.swift
//  NeuroLearn
//
//  Created by Dev Jr. 15 on 19/04/26.
//

import SwiftUI

struct HistoricView: View {
    var body: some View {
        VStack {
            Image(systemName: "safari.fill")
                .resizable()
                .scaledToFit()
                .frame(height: 50)
                .gradientForeground(
                    colors: [.second, .accent],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .padding(.bottom, 10)
            
            Text("Browse")
                .font(.title2)
                .fontDesign(.rounded)
                .fontWeight(.bold)
                .foregroundStyle(.accent)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        // Matches the global app background
        .background(Color.third.opacity(0.4).ignoresSafeArea())
    }
}

#Preview {
    HistoricView()
}
