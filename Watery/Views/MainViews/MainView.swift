//
//  MainView.swift
//  Watery
//
//  Created by Tom Stich on 26.11.20.
//

import SwiftUI
import ComposableArchitecture

struct MainView: View {
    let store : Store<DrinksState, DrinksAction> = Store(
        initialState: DrinksState(drinks: Drink.exampleDrinks),
        reducer: drinksReducer,
        environment: DrinksEnvironment(uuid: { UUID() } ))
    
    var body: some View {
        VStack {
            ScrollView {
                Text("WATERY")
                    .foregroundColor(ColorManager.wateryBlue)
                
                ContainerView(){
                    StatisticsView(store: self.store)
                }
                
                ContainerView(){
                    RefuelView(store: self.store)
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
