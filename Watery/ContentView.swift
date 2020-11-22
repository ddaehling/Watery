//
//  ContentView.swift
//  Watery
//
//  Created by Daniel Dähling on 13.11.20.
//

import SwiftUI
import ComposableArchitecture

struct AppState: Equatable {
    var drinkState : DrinksState
    var settingState: SettingsState
    var parameterState: ParametersState
}

enum AppAction: Equatable {
    case drinksAction(DrinksAction)
    case parametersAction(ParametersAction)
    case settingsAction(SettingsAction)
}

struct AppEnvironment {
    var uuid: () -> UUID
}

let appReducer = Reducer<
AppState, AppAction, AppEnvironment
>.combine(
    drinksReducer
        .pullback(
        state: \AppState.drinkState,
        action: /AppAction.drinksAction,
            environment: { environment in .init(uuid: environment.uuid()) }),
    parametersReducer
        .pullback(
        state: \AppState.parameterState,
        action: /AppAction.parametersAction,
        environment: { _ in .init() }),
    settingsReducer
        .pullback(
        state: \AppState.settingState,
        action: /AppAction.settingsAction,
        environment: { _ in .init() })
)

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
