//
//  BrainThinkingAnimation.swift
//  NeuroLearn
//
//  Created by Ultiimate Dog on 19/04/26.
//

import SwiftUI

// MARK: - Floating Icon
struct FloatingIcon: Identifiable {
    let id = UUID()
    let systemName: String
    var angle: Double
    var radius: CGFloat
    var scale: CGFloat
    var opacity: Double
}

struct BrainThinkingAnimation: View {
    
    let innerRadius: CGFloat   // 👈 new
    
    @State private var icons: [FloatingIcon] = []
    
    let symbols = [
        "lightbulb.fill",
        "book.fill",
        "brain.head.profile",
        "atom",
        "chart.bar.fill",
        "function",
        "sum",
        "globe",
        "gearshape.fill",
        "doc.text.fill",
        "pencil.and.outline",
        "magnifyingglass",
        "sparkles",
        "bolt.fill",
        "graduationcap.fill"
    ]
    
    var body: some View {
        ZStack {
            ForEach(icons) { icon in
                Image(systemName: icon.systemName)
                    .foregroundStyle(.accent)
                    .scaleEffect(icon.scale)
                    .opacity(icon.opacity)
                    .offset(
                        x: cos(icon.angle) * icon.radius,
                        y: sin(icon.angle) * icon.radius
                    )
            }
        }
        .frame(width: innerRadius * 3, height: innerRadius * 3)
        .onAppear {
            startAnimation()
        }
    }
    
    private func startAnimation() {
        // Spawn new icons repeatedly
        Timer.scheduledTimer(withTimeInterval: 0.6, repeats: true) { _ in
            addIcon()
        }
    }
    
    private func addIcon() {
        
        var angle: Double = 0
        var spawnRadius: CGFloat = 0
        var attempts = 0
        
        repeat {
            angle = Double.random(in: .pi...(2 * .pi))
            spawnRadius = CGFloat.random(in: innerRadius + 10 ... innerRadius + 60)
            attempts += 1
        } while !isPositionValid(angle: angle, radius: spawnRadius) && attempts < 10
        
        let icon = FloatingIcon(
            systemName: symbols.randomElement()!,
            angle: angle,
            radius: spawnRadius,
            scale: 0.5,
            opacity: 0
        )
        
        icons.append(icon)
        
        withAnimation(.easeOut(duration: 2.5)) {
            update(icon.id) {
                $0.scale = 1.2
                $0.opacity = 1
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
            withAnimation(.easeIn(duration: 0.8)) {
                update(icon.id) { $0.opacity = 0 }
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.7) {
            icons.removeAll { $0.id == icon.id }
        }
    }
    
    private func update(_ id: UUID, _ changes: (inout FloatingIcon) -> Void) {
        guard let i = icons.firstIndex(where: { $0.id == id }) else { return }
        changes(&icons[i])
    }
    
    private func isPositionValid(angle: Double, radius: CGFloat) -> Bool {
        let newX = cos(angle) * radius
        let newY = sin(angle) * radius
        
        let minDistance: CGFloat = 28 // tweak depending on icon size
        
        for icon in icons {
            let x = cos(icon.angle) * icon.radius
            let y = sin(icon.angle) * icon.radius
            
            let dx = newX - x
            let dy = newY - y
            let distance = sqrt(dx * dx + dy * dy)
            
            if distance < minDistance {
                return false
            }
        }
        
        return true
    }
}

#Preview {
    BrainThinkingAnimation(innerRadius: 30)
}
