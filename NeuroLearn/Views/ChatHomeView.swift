import SwiftUI

struct ChatHomeView: View {
    @State private var input: String = ""
    @State private var destination: Landmark?
    
    @State private var isDictating: Bool = false

    // MARK: - Body
    var body: some View {
        NavigationStack {
            VStack(spacing: 25) {
                                
                header()
                
                Spacer()
                
                middle()
                
                Spacer()
                
                searchBar()
                
            }
            .navigationDestination(item: $destination) {
                LearningTripView(landmark: $0)
                    .toolbar(.hidden, for: .tabBar)
                    
            }
            .background(Color.third.opacity(0.4).ignoresSafeArea())
        }
    }
    
    // MARK: - Header
    private func header() -> some View {
        HStack(spacing: 10) {
            
            //historyButton()
            
            //Spacer()
            
            Image(systemName: "brain.fill")
                .resizable()
                .scaledToFit()
                .frame(height: 35)
                .gradientForeground(
                    colors: [.second, .accent],
                    startPoint: .top,
                    endPoint: .bottom
                )
            
            VStack(alignment: .leading, spacing: 0) {
                
                Text("NeuroFlow AI")
                    .font(.title2)
                    .fontWeight(.heavy)
                    .fontDesign(.rounded)
                    .kerning(1.5)
                    .lineLimit(1)
                    .gradientForeground(
                        colors: [.second, .accent],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                
                Text("Learn the way your brain needs")
                    .font(.footnote)
                    .fontDesign(.rounded)
                    .bold()
                    .foregroundStyle(.second)
                    .lineLimit(1)
            }
            
            Spacer()
            
            notificationButton()
        }
        .padding(.horizontal, 20)
    }
    
    // MARK: - History Button
    private func historyButton() -> some View {
        Button {
            
        } label: {
            Image(systemName: "line.horizontal.3.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(height: 35)
                .fontWeight(.semibold)
                .foregroundStyle(.accent)
        }
    }
    
    // MARK: - Notification Button
    private func notificationButton() -> some View {
        Button {
            
        } label: {
            Image(systemName: "bell.badge.fill")
                .resizable()
                .scaledToFit()
                .frame(height: 32)
                .foregroundStyle(.accent)
        }
    }
    
    // MARK: - Middle
    @ViewBuilder
    private func middle() -> some View {
        Image(systemName: "brain.fill")
            .resizable()
            .scaledToFit()
            .frame(height: 60)
            .gradientForeground(
                colors: [.second, .accent],
                startPoint: .top,
                endPoint: .bottom
            )
            .shimmer(isActive: input.isEmpty)
        
        VStack {
            Text("Hi, François!")
                .font(.title2)
                .fontDesign(.rounded)
                .fontWeight(.bold)
                .foregroundStyle(.accent)
                .lineLimit(1)
            
            Text("What are we learning ?")
                .font(.title)
                .fontDesign(.rounded)
                .fontWeight(.bold)
                .foregroundStyle(.accent)
                .lineLimit(1)
        }
    }
    
    // MARK: - Search Bar
    private func searchBar() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 22)
                .frame(height: 65)
                .foregroundStyle(.second)
                .shadow(color: .second, radius: 1, y: 2)
            
            RoundedRectangle(cornerRadius: 20)
                .frame(height: 60)
                .foregroundStyle(.white)
                .padding(.horizontal, 2.5)
                
            HStack {
                
                TextField(text: $input) {
                    Text("Search for anything...")
                        .fontDesign(.rounded)
                        .font(.body)
                        .fontWeight(.semibold)
                        .kerning(0.5)
                        .lineLimit(1)
                        .foregroundStyle(.second)
                }
                .foregroundStyle(.accent)
                .fontDesign(.rounded)
                .font(.body)
                .fontWeight(.semibold)
                .kerning(0.5)
                .onSubmit {
                    destination = .virtual(name: input)
                }
                
                Button {
                    withAnimation {
                        isDictating.toggle()
                    }
                } label: {
                    Image(systemName: isDictating ? "waveform.badge.microphone" :  "microphone.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 33)
                        .fontWeight(.semibold)
                        .gradientForeground(
                            colors: [.second, .accent],
                            startPoint: .top,
                            endPoint: .center
                        )
                        .contentTransition(.symbolEffect(.replace.magic(fallback: .downUp.byLayer), options: .nonRepeating))
                        .symbolEffect(.variableColor.cumulative.dimInactiveLayers.nonReversing, options: isDictating ? .repeat(.continuous) : .default, value: isDictating)
                }
                .padding(.trailing, 5)
                
                Button {
                    destination = .virtual(name: input)
                } label: {
                    Image(systemName: "arrow.up.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 35)
                        .fontWeight(.medium)
                        .gradientForeground(
                            colors: [.second, .accent],
                            startPoint: .top,
                            endPoint: .center
                        )
                }
                .disabled(input.isEmpty)
                
            }
            .padding(.horizontal, 20)

        }
        .padding([.horizontal, .bottom], 10)
    }
}

#Preview {
    ChatHomeView()
}
