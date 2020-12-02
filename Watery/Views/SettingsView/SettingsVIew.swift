//
//  SettingsVIew.swift
//  Watery
//
//  Created by Daniel Dähling on 02.12.20.
//

import SwiftUI
import ComposableArchitecture

struct SettingsState: Equatable {
    var theme: Theme
    var textSize: TextSize
    
    init(theme : Theme = .dark, textSize : TextSize = .medium) {
        self.theme = theme
        self.textSize = textSize
    }
    
    static var exampleSettingsState : SettingsState = .init(theme: .dark, textSize: .medium)
}

enum Theme: Equatable {
    case light
    case dark
}

enum TextSize: Equatable {
    case verySmall
    case small
    case medium
    case large
    case veryLarge
}

enum SettingsAction: Equatable {
    case themeSettingChanged(Theme)
    case textSizeChanged(TextSize)
}

struct SettingsEnvironment {}

let settingsReducer = Reducer<
    SettingsState, SettingsAction, SettingsEnvironment
> { settingsState, settingsAction, settingsEnvironment in
    switch settingsAction {
    case let .themeSettingChanged(theme):
        return .none
    case let .textSizeChanged(textSize):
        return .none
    }
}


struct SettingsView: View {
    let store : Store<SettingsState, SettingsAction>
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(
            store: Store(
                initialState: .exampleSettingsState,
                reducer: settingsReducer,
                environment: SettingsEnvironment()))
    }
}
