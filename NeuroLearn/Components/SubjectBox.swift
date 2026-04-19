//
//  SubjectBox.swift
//  NeuroFlow
//
//  Created by Ultiimate Dog on 18/04/26.
//

import SwiftUI

struct SubjectBox: View {
    let title: String
    let icon: String
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(.accent)
            
            Text(title)
                .font(.footnote)
                .fontDesign(.rounded)
                .fontWeight(.bold)
                .foregroundStyle(.accent)
                .multilineTextAlignment(.center)
        }
        .frame(width: 100, height: 100)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(color: .second, radius: 1)
                .shadow(color: .second, radius: 2)
        )
    }
}

#Preview {
    SubjectBox(title: "Boxy", icon: "heart")
}
