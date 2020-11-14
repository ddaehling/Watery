//
//  DrinksView.swift
//  Watery
//
//  Created by Daniel Dähling on 14.11.20.
//

import SwiftUI
import ComposableArchitecture

struct DrinksState: Equatable {
    var drinks: [Drink]
    var drinksForSelectedWeek: [Drink] {
        drinks.filter { $0.date == nil }
    }
}

struct Drink: Equatable {
    let date: Date
    private let size: Double
    
    init(date: Date = Date(), size: Size) {
        self.date = date
        switch size {
        case .small:
            self.size = 0.3
        case .medium:
            self.size = 0.5
        case .large:
            self.size = 1.0
        case let .custom(size):
            self.size = size
        }
    }
}

enum Size: Equatable {
    case small
    case medium
    case large
    case custom(size: Double)
}

enum DrinksAction: Equatable {
    case drinkAdded(Drink)
}

struct DrinksEnvironment {}

let drinksReducer = Reducer<
DrinksState, DrinksAction, DrinksEnvironment
> { drinksState, drinksAction, drinksEnvironment in
    switch drinksAction {
    case let .drinkAdded(drink):
        drinksState.drinks.append(drink)
        //TODO: Include stable sort
        return .none
    }
}

struct DrinksView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct DrinksView_Previews: PreviewProvider {
    static var previews: some View {
        DrinksView()
    }
}
