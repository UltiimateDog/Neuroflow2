import SwiftUI
import Charts
import FoundationModels

struct LearningChartView: View {
    // This will now find 'ChartElement' because it's in the same target
    let data: [ChartElement].PartiallyGenerated
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Visual Overview")
                .font(.headline)
            
            Chart(data) { element in
                if let label = element.label, let value = element.value {
                    BarMark(
                        x: .value("Category", label),
                        y: .value("Value", value)
                    )
                    .foregroundStyle(.indigo.gradient)
                    .cornerRadius(8)
                }
            }
            .frame(height: 200)
        }
        .card() // Reusing your professional card style
        .transition(.neuroFluid) // Reusing your fluid transition
    }
}
