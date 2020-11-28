//
//  Drink.swift
//  Watery
//
//  Created by Daniel Dähling on 24.11.20.
//

import Foundation

struct Drink: Equatable, Identifiable {
    let date: Date
    let id: UUID
    let type: DrinkType
    var netWorth: Double
    
    init(date: Date = Date(), id: UUID, size: DrinkSize, type: DrinkType) {
        self.date = date
        self.id = id
        self.type = type
        
        let quality = type.getQuality()
        let size = size.getSize()
        
        func calculateNetWorth() -> Double {
            switch quality {
            case .neutral:
                return size * 1
            case .bad:
                return size * 0.7
            case .veryBad:
                return size * 0.5
            }
        }
        
        self.netWorth = calculateNetWorth()
    }
    
    
    
    static var exampleDrink : Drink = .init(date: Date(), id: UUID(), size: .medium(), type: .tea())
    static var exampleDrinks : [Drink] = [
        .init(date: Date(), id: UUID(), size: .medium(), type: .tea()),
        .init(date: Date(), id: UUID(), size: .large(), type: .lemonade()),
        .init(date: Date(), id: UUID(), size: .small(), type: .juice())
    ]
}

enum Quality {
    case neutral, bad, veryBad
}

enum DrinkImage: String {
    case tea = "Tea1"
    case spritzer = "Spritzer1"
    case lemonade = "Lemonade1"
    case coffee = "Coffee1"
    case juice = "Juice1"
    case lightdrinks = "Lightdrinks1"
}

enum DrinkType: Equatable {
    case water(Quality = .neutral)
    case tea(Quality = .neutral)
    case spritzer(Quality = .veryBad)
    case lemonade(Quality = .veryBad)
    case coffee(Quality = .bad)
    case juice(Quality = .veryBad)
    case lightdrinks(Quality = .veryBad)
    
    func getQuality() -> Quality {
        switch self {
        case let .water(q), let .tea(q), let .spritzer(q), let .lemonade(q), let .coffee(q), let .juice(q), let .lightdrinks(q):
            return q
        }
    }
}

enum DrinkSize: Equatable {
    case small(Double = 0.3)
    case medium(Double = 0.5)
    case large(Double = 1)
    case custom(Double)
    
    func getSize() -> Double {
        switch self {
        case let .small(s), let .medium(s), let .large(s), let .custom(s):
            return s
        }
    }
}
