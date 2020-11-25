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
    
    init(exertions: [Exertion] = [], personalData : PersonalData = .standard) {
        self.exertions = exertions
        self.personalData = personalData
    }
    
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
        
        static var standard : PersonalData = .init(height: 170, weight: 140, age: 40, healthRisks: [])
    }
    
    static var exampleParameterState : ParametersState = .init(
        exertions: [Exertion(
                        calories: 400,
                        date: .init(timeIntervalSince1970: 1606238341)),
                     Exertion(
                         calories: 300,
                         date: .init(timeIntervalSince1970: 1606151941)),
                     Exertion(
                         calories: 600,
                         date: .init(timeIntervalSince1970: 1606065541))],
        personalData: PersonalData(
            height: 188,
            weight: 204,
            age: 53,
            healthRisks: [
                .heartCondition,
                .obese
            ]))
    
    static var initialParameterState : ParametersState = .init(
        exertions: [],
        personalData: PersonalData(
            height: 180,
            weight: 150,
            age: 40,
            healthRisks: []))
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
    let store : Store<ParametersState, ParametersAction>
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ParametersView_Previews: PreviewProvider {
    static var previews: some View {
        ParametersView(
            store: Store(
                initialState: .exampleParameterState,
                reducer: parametersReducer,
                environment: ParametersEnvironment()))
    }
}
