import SwiftUI
import os

enum Logging {
    static let subsystem = "com.devjr.NeuroLearn"
    static let general = Logger(subsystem: subsystem, category: "General")
}

// Professional "Signature" Spring for NeuroLearn
extension Animation {
    static var neuroSpring: Animation {
        // response: 0.5 makes it fluid, dampingFraction: 0.7 adds a subtle, professional bounce
        .spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0)
    }
}


extension View {
    /// The structural boundary for TEACCH-aligned information chunks
    func teacchCard(color: Color = Color(.secondarySystemBackground)) -> some View {
        self.padding(20)
            .background(color)
            .cornerRadius(20)
            .padding(.horizontal)
    }
}

extension AnyTransition {
    /// The signature fluid transition for NeuroLearn
    static var neuroFluid: AnyTransition {
        .asymmetric(
            insertion: .opacity
                .combined(with: .scale(scale: 0.92))
                .combined(with: .move(edge: .bottom)),
            removal: .opacity.combined(with: .scale(scale: 1.05))
        )
    }
}

extension Text {
    /// Dyslexia-friendly text style
    func dyslexicStyle(size: CGFloat = 18, weight: Font.Weight = .medium) -> some View {
        self.font(.system(size: size, weight: weight, design: .rounded))
            .lineSpacing(8) // Increased leading is critical for dyslexia
            .kerning(0.5)   // Slight letter spacing improvement
    }
}
