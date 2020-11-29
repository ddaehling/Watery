//
//  CupSizeButtonView.swift
//  Watery
//
//  Created by Tom Stich on 25.11.20.
//

import SwiftUI
import ComposableArchitecture

enum SelectedDrinkSizeAction: Equatable {
    case selectedDrinkChanged(DrinkSize)
}

struct CupSizeButtonView: View {
    
    let store : Store<DrinkSize, SelectedDrinkSizeAction>
    private let generator = UINotificationFeedbackGenerator()
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            HStack {
                Button(action: {
                    self.generator.notificationOccurred(.warning)
                    viewStore.send(.selectedDrinkChanged(viewStore.state))
                }, label: {
                    ZStack {
                        Circle()
                            .stroke(ColorManager.wateryBlue, lineWidth: 2)
                            .frame(width: 36, height: 36)
                        Text("\(viewStore.state.description)")
                            .font(.system(size: 15))
                    }
                }).buttonStyle(PlainButtonStyle())
            }
        }
    }
}
