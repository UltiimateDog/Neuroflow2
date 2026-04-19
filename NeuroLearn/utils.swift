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

extension AnyTransition {
    /// A high-quality, professional transition that works on all iOS versions.
    /// This uses scale, opacity, and movement to create a 'foundational' feel.
    static var neuroFluid: AnyTransition {
        .asymmetric(
            insertion: AnyTransition.opacity
                .combined(with: .scale(scale: 0.92))
                .combined(with: .move(edge: Edge.bottom)),
            removal: AnyTransition.opacity
                .combined(with: .scale(scale: 1.05))
        )
    }
}

struct ReadabilityRoundedRectangle: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 16.0)
            .fill(
                LinearGradient(
                    colors: [.black.opacity(0.8), .clear],
                    startPoint: .bottom,
                    endPoint: .center
                )
            )
    }
}

extension View {
    /// A professional card modifier for educational content
    func card() -> some View {
        self.padding()
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
    }
}
