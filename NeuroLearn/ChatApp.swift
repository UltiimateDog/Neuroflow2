//
//  ChatApp.swift
//  NeuroLearn
//
//  Created by Dev Jr. 15 on 18/04/26.
//

import SwiftUI

@main
struct ChatApp: App {
    // We remove the dependency on a static JSON file since we are
    // using dynamic "Virtual Landmarks" from the chat input.
    
    var body: some Scene {
        WindowGroup {
            LandingView()
        }
    }
}
