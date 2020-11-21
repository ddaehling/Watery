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
}

struct Drink: Equatable, Identifiable {
    let date: Date
    let id: UUID
    private let size: Double
    
    init(date: Date = Date(), size: Size, quality: Quality = .neutral) {
        self.date = date
        func calculateNetWorth(for size: Double, quality: Quality) -> Double {
            switch quality {
            case .neutral:
                return size * 1
            case .bad:
                return size * 0.7
            case .veryBad:
                return size * 0.5
            }
        }
        
        switch size {
        case .small:
            self.size = calculateNetWorth(for: 0.3, quality: quality)
        case .medium:
            self.size = calculateNetWorth(for: 0.5, quality: quality)
        case .large:
            self.size = calculateNetWorth(for: 1, quality: quality)
        case let .custom(size):
            self.size = calculateNetWorth(for: size, quality: quality)
        }
    }
}

enum Quality {
    case neutral, bad, veryBad
}

enum Size: Equatable {
    case small
    case medium
    case large
    case custom(size: Double)
}

enum DrinksAction: Equatable {
    case drinkAdded(Drink)
//    case drinksOverViewAction(OverviewAction)
    case drinkDeleted(DrinksOverViewAction)
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
    case .drinkDeleted:
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
