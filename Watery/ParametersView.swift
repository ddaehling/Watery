//
//  ParametersView.swift
//  Watery
//
//  Created by Daniel Dähling on 14.11.20.
//

import SwiftUI
import ComposableArchitecture

struct ParametersState: Equatable {
    var exertions: [Exertion]
    var personalData: PersonalData
    
    private var riskFactor: Double {
        // TODO: enter groundbreaking algorithm here (based on healthRisks)
        return 0
    }
    
    private var liquidsRequirement: Double {
        // TODO: enter groundbreaking algorithm here (based on riskFactor, exertions, height, weight and age)
        return 0
    }
    
    struct PersonalData: Equatable {
        var height: Double
        var weight: Double
        var age: Double
        var healthRisks: [HealthRisk]
    }
}

struct Exertion: Equatable {
    let calories: Double
    let date: Date
}

enum HealthRisk: Equatable {
    case overweight
    case obese
    case heartCondition
    case stroke
    case thrombosis
}

enum ParametersAction: Equatable {
    case exertionAdded(Exertion)
    case personalDataChanged(ParametersState.PersonalData)
}

struct ParametersEnvironment {}

let parametersReducer = Reducer<
ParametersState, ParametersAction, ParametersEnvironment
> { parametersState, parametersAction, parametersEnvironment in
    switch parametersAction {
    case let .exertionAdded(exertion):
        parametersState.exertions.append(exertion)
        //TODO: Include stable sort
        return .none
    case let .personalDataChanged(personalData):
        parametersState.personalData = personalData
        return .none
    }
}

struct ParametersView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ParametersView_Previews: PreviewProvider {
    static var previews: some View {
        ParametersView()
    }
}
