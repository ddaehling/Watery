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
    private let size: Double
    
    init(date: Date = Date(), id: UUID, size: Size, quality: Quality = .neutral) {
        self.date = date
        self.id = id
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
    
    static var exampleDrink : Drink = .init(date: Date(), id: UUID(), size: .medium, quality: .neutral)
    static var exampleDrinks : [Drink] = [
        .init(date: Date(), id: UUID(), size: .medium, quality: .neutral),
        .init(date: Date(), id: UUID(), size: .large, quality: .bad),
        .init(date: Date(), id: UUID(), size: .small, quality: .veryBad)
    ]
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
