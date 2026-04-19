import SwiftUI
import Charts
import FoundationModels

struct LearningChartView: View {
    // We use PartiallyGenerated to allow the chart to build as the AI streams data
    let data: [ChartElement].PartiallyGenerated
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Visual Overview")
                .dyslexicStyle(size: 20, weight: .bold) // Using the new dyslexia-friendly style
            
            Chart(data) { element in
                // Safely unwrap the streaming values
                if let label = element.label, let value = element.value {
                    BarMark(
                        x: .value("Category", label),
                        y: .value("Importance", value)
                    )
                    .foregroundStyle(.indigo.gradient)
                    .cornerRadius(8)
                }
            }
            .frame(height: 200)
            .chartYAxis(.hidden) // Keep it simple for neurodivergent clarity
        }
        // FIX 1: Use the updated TEACCH card modifier
        .teacchCard()
        // FIX 2: Explicitly reference AnyTransition to help the compiler infer the base
        .transition(AnyTransition.neuroFluid)
    }
}
