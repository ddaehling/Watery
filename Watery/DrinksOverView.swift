//
//  DrinksOverView.swift
//  Watery
//
//  Created by Daniel Dähling on 21.11.20.
//

import SwiftUI
import ComposableArchitecture

enum DrinksOverViewAction: Equatable {
    case drinkDetailAction(id: Int, action: DrinksDetailAction)
    case drinkDeleted(IndexSet)
}

let drinksOverViewReducer = Reducer<
    DrinksState, DrinksOverViewAction, DrinksEnvironment
>.combine(
    drinksDetailReducer.forEach(
        state: \.drinks,
        action: /DrinksOverViewAction.drinkDetailAction(id:action:),
        environment: { _ in }),
    Reducer { state, action, environment in
        switch action {
        case .drinkDetailAction:
            return .none
        case let .drinkDeleted(indexSet):
            state.drinks.remove(atOffsets: indexSet)
            return .none
        }
    }
)

struct DrinksOverView: View {
    let store : Store<DrinksState, DrinksOverViewAction>
    
    var body: some View {
        WithViewStore(self.store.scope(state: { $0.drinks })) { viewStore in
            NavigationView {
                List {
                    ForEachStore(
                        self.store.scope(
                            state: { $0.drinks },
                            action: DrinksOverViewAction.drinkDetailAction(id:action:)),
                            content: DrinkDetailView.init(store:))
                    .onDelete { viewStore.send(.drinkDeleted($0)) }
                }
            }
        }
        
        
    }
}


struct DrinksOverView_Previews: PreviewProvider {
    static var previews: some View {
        DrinksOverView(
            store: Store(
                initialState: DrinksState(drinks: Drink.exampleDrinks),
                reducer: drinksOverViewReducer,
                environment: DrinksEnvironment(uuid: UUID.init, generator: UINotificationFeedbackGenerator() )))
    }
}
