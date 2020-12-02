//
//  CupSizeGroupView.swift
//  Watery
//
//  Created by Tom Stich on 25.11.20.
//

import SwiftUI
import ComposableArchitecture

struct CupSelectionEnvironment {}

struct CupSizeGroupView: View {
    
    let store : Store<[DrinkSize], DrinksAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            ForEachStore(self.store.scope(state: {
                $0
            }, action: DrinksAction.cupSelectionAction(id:action:)),
            id: \.self,
            content: CupSizeButtonView.init(store:)
            )
        }
    }
}

struct CupSizeGroupView_Previews: PreviewProvider {
    static var previews: some View {
        CupSizeGroupView(store: Store(
                            initialState: [.small, .medium, .large, .custom(1.5)],
                            reducer: .empty,
                            environment: CupSelectionEnvironment() ))
    }
}
