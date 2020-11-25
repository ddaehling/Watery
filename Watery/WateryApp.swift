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
    var body: some Scene {
        WindowGroup {
            ContentView(store: Store(initialState: AppState(), reducer: appReducer, environment: AppEnvironment(uuid: { UUID() } )))
        }
    }
}
