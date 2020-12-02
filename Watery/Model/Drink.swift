//
//  Drink.swift
//  Watery
//
//  Created by Daniel Dähling on 02.12.20.
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
    
    static var exampleDrink : Drink = .init(date: Date(), id: UUID(), size: .medium, type: .tea)
    static var exampleDrinks : [Drink] = [
        .init(date: Date(), id: UUID(), size: .small, type: .tea),
        .init(date: Date(), id: UUID(), size: .large, type: .lemonade),
        .init(date: Date(), id: UUID(), size: .small, type: .juice)
    ]
}

enum Quality {
    case neutral, bad, veryBad
}

enum DrinkImage: String, CaseIterable {
    case tea = "Tea1"
    case spritzer = "Spritzer1"
    case lemonade = "Lemonade1"
    case coffee = "Coffee1"
    case juice = "Juice1"
    case lightdrinks = "Lightdrinks1"
}

enum DrinkType: String, Equatable, CaseIterable {
    
    case water
    case tea
    case spritzer
    case lemonade
    case coffee
    case juice
    case lightdrinks
    
    func getQuality() -> Quality {
        switch self {
        case .water, .tea:
            return .neutral
        case .spritzer, .juice, .lemonade:
            return .veryBad
        case .coffee, .lightdrinks:
            return .bad
        }
    }
}


enum DrinkSize: Equatable, Hashable, CustomStringConvertible {
    
    var description: String {
        switch self {
        case .small:
            return "0.3l"
        case .medium:
            return "0.5l"
        case .large:
            return "1.0l"
        case let .custom(size):
            return "\(size)l"
        }
    }
    
    case small
    case medium
    case large
    case custom(Double)
    
    func getSize() -> Double {
        switch self {
        case .small:
            return 0.3
        case .medium:
            return 0.5
        case .large:
            return 1
        case let .custom(size):
            return size
        }
    }
}
