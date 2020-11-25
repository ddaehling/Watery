//
//  ContentView.swift
//  Watery
//
//  Created by Daniel Dähling on 13.11.20.
//

import SwiftUI
import ComposableArchitecture

struct AppState: Equatable {
    var drinkState : DrinksState = DrinksState()
    var settingState: SettingsState = SettingsState()
    var parameterState: ParametersState = ParametersState()
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
        environment: { environment in .init(uuid: environment.uuid) }),
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
    var store : Store<AppState, AppAction>
    
    var body: some View {
        RefuelView()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
            store: Store(
                initialState: AppState(
                    drinkState: DrinksState.exampleDrinksState,
                    settingState: SettingsState.exampleSettingsState,
                    parameterState: ParametersState.exampleParameterState),
                reducer: appReducer,
                environment: AppEnvironment(uuid: { UUID() })))
    }
}
