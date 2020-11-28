//
//  StatisticView.swift
//  Watery
//
//  Created by Tom Stich on 26.11.20.
//

import SwiftUI
import ComposableArchitecture

struct StatisticView: View {
    let store : Store<DrinksState, DrinksAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            Text(String(viewStore.dailyConsumtion))
        }
    }
}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticView()
    }
}
