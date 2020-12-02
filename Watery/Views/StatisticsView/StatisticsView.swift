//
//  StatisticsView.swift
//  Watery
//
//  Created by Daniel Dähling on 02.12.20.
//

import SwiftUI
import ComposableArchitecture

struct StatisticsView: View {
    let store : Store<DrinksState, DrinksAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            
            VStack(alignment: .leading) {
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading) {
                        
                        Text("Today.")
                            .foregroundColor(ColorManager.wateryBlue)
                            .font(.system(size: 25))
                            .fontWeight(.bold)
                        
                        Text(self.getPercentage(goal: 2.5, dailyConsumption: viewStore.dailyConsumption))
                            .font(.system(size: 45))
                            .fontWeight(.bold)
                            .foregroundColor(ColorManager.wateryBlue)
                        
                        
                    }
                    Text("\(String(format: "%.1f", viewStore.dailyConsumption))l")
                        .font(Font.title.weight(.regular))
                        .foregroundColor(ColorManager.wateryBlue)
                }
                .padding()
                
                VStack(alignment: .leading) {
                    Text("History.")
                        .foregroundColor(ColorManager.wateryBlue)
                        .font(.title2)
                        .bold()
                }.padding()
                BarChartView(store: self.store.scope(state: { $0.barChartState }, action: DrinksAction.barChartAction))
            }
        }
    }
    
    func getPercentage(goal: Double = 2.5, dailyConsumption: Double = 0) -> String {
        return "\(String(format: "%.0f", dailyConsumption / goal * 100))%"
    }
}

struct StatisticsView_Preview: PreviewProvider {
    static var previews: some View {
        StatisticsView( store: Store(
                            initialState: DrinksState(drinks: .init(Drink.exampleDrinks)),
                            reducer: drinksReducer,
                            environment: DrinksEnvironment(uuid: UUID.init, generator: UINotificationFeedbackGenerator() )))
    }
}
