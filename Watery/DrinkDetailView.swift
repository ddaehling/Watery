//
//  DrinkDetailView.swift
//  Watery
//
//  Created by Daniel Dähling on 21.11.20.
//

import SwiftUI
import ComposableArchitecture

let drinksDetailReducer = Reducer<Drink, DrinksDetailAction, Void> { state, action, _ in
    switch action {
    case let .drinkModified(drink):
        state = drink
        return .none
    }
}

enum DrinksDetailAction: Equatable {
    case drinkModified(Drink)
}

struct DrinkDetailView: View {
    let store : Store<Drink, DrinksDetailAction>
    
    var body: some View {
        EmptyView()
    }
}

//
//struct DrinkDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DrinkDetailView()
//    }
//}
