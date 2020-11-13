//
//  AppState.swift
//  Watery
//
//  Created by Daniel Dähling on 13.11.20.
//

import Foundation
import SwiftUI

struct AppState: Equatable {
    var drinkState : DrinksState
    var settingState: SettingsState
    var parameterState: PersonalState
}

struct DrinksState: Equatable {
    var drinks: [Drink]
    var drinksForSelectedWeek: [Drink] {
        drinks.filter { $0.date == nil }
    }
}

struct SettingsState: Equatable {
    var theme: Theme
    var textSize: TextSize
}

enum Theme: Equatable {
    case light
    case dark
}

enum TextSize: Equatable {
    case verySmall
    case small
    case medium
    case large
    case veryLarge
}

struct PersonalState: Equatable {
    var exertions: [Exertion]
    var height: Double
    var weight: Double
    var age: Double
    var healthRisks: [HealthRisk]
    
    private var riskFactor: Double {
        // TODO: enter groundbreaking algorithm here (based on healthRisks)
        return 0
    }
    
    private var liquidsRequirement: Double {
        // TODO: enter groundbreaking algorithm here (based on riskFactor, exertions, height, weight and age)
        return 0
    }
}

struct Exertion: Equatable {
    let calories: Double
    let date: Date
}

enum HealthRisk {
    case overweight
    case obese
    case heartCondition
    case stroke
    case thrombosis
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
