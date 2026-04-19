//
//  LearningStepBox.swift
//  NeuroLearn
//
//  Created by Ultiimate Dog on 19/04/26.
//

import SwiftUI

struct LearningStepBox: View {
    let index: Int
    let title: String
    let explanation: String
    let takeaway: String
    
    @Namespace private var namespace
    
    @State private var speech = SpeechManager()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.third)
                        .frame(width: 50, height: 50)
                    
                    Text("\(index)")
                        .font(.title2.bold())
                        .foregroundStyle(.accent)
                }
                
                Text(title)
                    .foregroundStyle(.accent)
                    .dyslexicStyle(size: 20, weight: .bold)
                
                Spacer()
                
                ZStack {
                    if speech.isSpeaking {
                        Image(systemName: "speaker.wave.2.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 32)
                            .bold()
                            .gradientForeground(
                                colors: [.second, .accent],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                            .symbolEffect(.variableColor)
                            .matchedGeometryEffect(id: "speaker", in: namespace)
                        
                    } else {
                        Image(systemName: "speaker.wave.2.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25)
                            .bold()
                            .gradientForeground(
                                colors: [.second, .accent],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                            .matchedGeometryEffect(id: "speaker", in: namespace)
                    }
                }
                .frame(width: 25)
                .animation(.neuroSpring, value: speech.isSpeaking)
                
            }
            
            VStack(alignment: .leading, spacing: 10) {
                
                Text(explanation)
                    .foregroundStyle(.accent)
                    .dyslexicStyle()

                
                HStack {
                    Image(systemName: "star.fill")
                        .gradientForeground(
                            colors: [.second, .accent],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    
                    Text(takeaway)
                        .foregroundStyle(.accent)
                        .dyslexicStyle(size: 16, weight: .bold)
                    
                    Spacer()
                }
                .padding(8)
                .background(Color.third)
                .cornerRadius(10)
            }
            .padding(.leading, 10)
            
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 22)
                .fill(Color.white)
                .shadow(color: .second, radius: 1)
                .shadow(color: .second, radius: 2)
        )
        .padding(.horizontal, 15)
        .onTapGesture {
            speech.speak(explanation)
        }
    }
}

#Preview {
    LearningStepBox(index: 0, title: "Test", explanation: "Test", takeaway: "None")
}
