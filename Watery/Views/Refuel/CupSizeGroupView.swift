//
//  CupSizeGroupView.swift
//  Watery
//
//  Created by Tom Stich on 25.11.20.
//

import SwiftUI
import ComposableArchitecture


struct CupSizeGroupView: View {
    
    let store : Store<DrinksState, DrinksAction>
    
    var body: some View {
        HStack {
            
            CupSizeButtonView(name: "0.3l", cupSize: DrinkSizes.small, store: self.store)
            CupSizeButtonView(name: "0.5l",cupSize: DrinkSizes.medium, store: self.store)
            CupSizeButtonView(name: "0.7l",cupSize: DrinkSizes.large, store: self.store)
            CupSizeButtonView(name: "1l",cupSize: DrinkSizes.custom, store: self.store)
        }
    }
}

struct CupSizeGroupView_Previews: PreviewProvider {
    static var previews: some View {
        CupSizeGroupView( store: Store(
                            initialState: DrinksState(drinks: Drink.exampleDrinks),
                            reducer: drinksReducer,
                            environment: DrinksEnvironment(uuid: { UUID() } )))
    }
}
