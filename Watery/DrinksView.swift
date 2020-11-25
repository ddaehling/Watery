//
//  DrinksView.swift
//  Watery
//
//  Created by Daniel Dähling on 14.11.20.
//

import SwiftUI
import ComposableArchitecture

struct DrinksState: Equatable {
    var drinks: IdentifiedArrayOf<Drink>
    
    init(drinks : [Drink] = []) {
        self.drinks = .init(drinks)
    }
    
    static var exampleDrinksState : DrinksState = .init(drinks: .init(Drink.exampleDrinks))
}

enum DrinksAction: Equatable {
    case drinkAdded(Drink)
    case drinksOverViewAction(DrinksOverViewAction)
}

struct DrinksEnvironment {
    let uuid: () -> UUID
}

let drinksReducer = Reducer<
    DrinksState, DrinksAction, DrinksEnvironment
>.combine(
    drinksOverViewReducer.pullback(state: \.self, action: /DrinksAction.drinksOverViewAction, environment: { $0 }),
    Reducer { drinksState, drinksAction, drinksEnvironment in
        switch drinksAction {
        case let .drinkAdded(drink):
            drinksState.drinks.append(drink)
            //TODO: Include stable sort
            return .none
        case .drinksOverViewAction(_):
            return .none
        }
    }
)

struct DrinksView: View {
    let store : Store<DrinksState, DrinksAction>
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct DrinksView_Previews: PreviewProvider {
    static var previews: some View {
        DrinksView(
            store: Store(
                initialState: DrinksState(drinks: Drink.exampleDrinks),
                reducer: drinksReducer,
                environment: DrinksEnvironment(uuid: { UUID() } )))
    }
}
