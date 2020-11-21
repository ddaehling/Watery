//
//  DrinksOverView.swift
//  Watery
//
//  Created by Daniel Dähling on 21.11.20.
//

import SwiftUI
import ComposableArchitecture

enum DrinksOverViewAction: Equatable {
    case drinkDeleted(id: Int, action: DrinksDetailAction)
}

struct DrinksOverView: View {
    let store : Store<DrinksState, DrinksAction>
    
    var body: some View {
        WithViewStore(self.store.scope(state: { $0.drinks })) { viewStore in
            NavigationView {
                List {
                    ForEachStore(self.store.scope(state: { $0.drinks }, action: DrinksOverViewAction.drinkDeleted(id:action:))) { drink in
                        EmptyView()
                    }
                }
            }
        }
        
        
    }
}


struct DrinksOverView_Previews: PreviewProvider {
    static var previews: some View {
        DrinksOverView()
    }
}
