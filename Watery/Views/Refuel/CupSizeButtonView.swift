//
//  CupSizeButtonView.swift
//  Watery
//
//  Created by Tom Stich on 25.11.20.
//

import SwiftUI
import ComposableArchitecture

struct CupSizeButtonView: View {
    let name: String
    let cupSize: DrinkSizes
    
    let store : Store<DrinksState, DrinksAction>
    
    let generator = UINotificationFeedbackGenerator()
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            HStack {
                Button(action: {
                    self.generator.notificationOccurred(.warning)
                    viewStore.send(.selectedDrinkChanged(viewStore.selectedDrinkId, self.cupSize))
                }, label: {
                    ZStack {
                        Circle()
                            .stroke(ColorManager.wateryBlue,  lineWidth: viewStore.selectedDrinkSize.rawValue == name ? 4 : 2)
                            .frame(width: 36, height: 36)
                        
                        Text(name)
                            .font(.system(size: 15))
                    }
                }).buttonStyle(PlainButtonStyle())
            }
        }
    }
}
