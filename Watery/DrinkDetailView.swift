//
//  DrinkDetailView.swift
//  Watery
//
//  Created by Daniel Dähling on 21.11.20.
//

import SwiftUI

enum DrinksDetailAction: Equatable {
    case drinkDeleted(Drink)
    case drinkModified(Drink)
}

struct DrinkDetailView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct DrinkDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DrinkDetailView()
    }
}
