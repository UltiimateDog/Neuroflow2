import SwiftUI

struct ChatHomeView: View {
    @State private var input: String = ""
    @State private var destination: Landmark?

    var body: some View {
        NavigationStack {
            VStack(spacing: 25) {
                Spacer()
                Image(systemName: "sparkles").font(.system(size: 60)).foregroundStyle(.indigo)
                Text("What are we learning?").font(.largeTitle.bold())
                
                HStack {
                    TextField("Search for anything...", text: $input)
                        .padding().background(.ultraThinMaterial).cornerRadius(12)
                    Button { destination = .virtual(name: input) } label: {
                        Image(systemName: "arrow.up.circle.fill").font(.system(size: 40))
                    }.disabled(input.isEmpty)
                }.padding()
                Spacer(); Spacer()
            }
            .navigationDestination(item: $destination) { LearningTripView(landmark: $0) }
        }
    }
}

#Preview {
    ChatHomeView()
}
