//
//  ShimmerModifier.swift
//  NeuroLearn
//
//  Created by Ultiimate Dog on 19/04/26.
//

import Foundation
import SwiftUI

struct ShimmerModifier: ViewModifier {
    var isActive: Bool

    @State private var offset: CGFloat = -1

    func body(content: Content) -> some View {
        content
            .overlay {
                GeometryReader { geo in
                    let width = geo.size.width

                    LinearGradient(
                        colors: [
                            .clear,
                            Color.white.opacity(0.2),
                            .clear
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    .frame(width: width * 0.6)
                    .offset(x: offset * width * 2)
                    .onAppear {
                        guard isActive else { return }
                        offset = -1
                        withAnimation(
                            .linear(duration: 2)
                            .repeatForever(autoreverses: false)
                        ) {
                            offset = 1
                        }
                    }
                }
            }
            .mask(content)
    }
}

extension View {
    func shimmer(isActive: Bool) -> some View {
        self.modifier(ShimmerModifier(isActive: isActive))
    }
}
