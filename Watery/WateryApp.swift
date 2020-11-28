//
//  WateryApp.swift
//  Watery
//
//  Created by Daniel Dähling on 13.11.20.
//

import SwiftUI
import ComposableArchitecture

@main
struct WateryApp: App {
    init() {
        UITabBar.appearance().barTintColor = .white
        UITabBar.appearance().clipsToBounds = true
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
