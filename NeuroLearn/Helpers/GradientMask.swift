//
//  GradientMask.swift
//  NeuroFlow
//
//  Created by Ultiimate Dog on 18/04/26.
//

import Foundation
import SwiftUI

struct GradientMask: ViewModifier {
    let colors: [Color]
    let startPoint: UnitPoint
    let endPoint: UnitPoint

    func body(content: Content) -> some View {
        content
            .overlay {
                LinearGradient(
                    colors: colors,
                    startPoint: startPoint,
                    endPoint: endPoint
                )
                .mask {
                    content
                }
            }
    }
}

extension View {
    func gradientForeground(
        colors: [Color],
        startPoint: UnitPoint = .top,
        endPoint: UnitPoint = .bottom
    ) -> some View {
        self.modifier(
            GradientMask(
                colors: colors,
                startPoint: startPoint,
                endPoint: endPoint
            )
        )
    }
}
