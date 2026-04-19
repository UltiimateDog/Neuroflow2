//
//  SubjectBox.swift
//  NeuroFlow
//
//  Created by Ultiimate Dog on 18/04/26.
//

import SwiftUI

struct SubjectBox: View {
    let title: AttributedString
    let icon: String
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: icon)
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(.accent)
            
            Text(title)
                .fontDesign(.rounded)
                .foregroundStyle(.accent)
                .multilineTextAlignment(.center)
        }
        .padding(.vertical, 10)
        .padding(.horizontal)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .shadow(color: .second, radius: 1)
                .shadow(color: .second, radius: 2)
        )
    }
}

#Preview {
    SubjectBox(title: "Boxy", icon: "heart")
}
