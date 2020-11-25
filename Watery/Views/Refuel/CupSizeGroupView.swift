//
//  CupSizeGroupView.swift
//  Watery
//
//  Created by Tom Stich on 25.11.20.
//

import SwiftUI

struct CupSizeGroupView: View {
    @Binding var selectedDrinkSize: Size
    
    var body: some View {
        HStack {
            CupSizeButtonView(name: "0.3l", cupSize: .small, selectedCupSize: $selectedDrinkSize)
            CupSizeButtonView(name: "0.5l",cupSize: .medium, selectedCupSize: $selectedDrinkSize)
            CupSizeButtonView(name: "0.7l",cupSize: .large, selectedCupSize: $selectedDrinkSize)
            CupSizeButtonView(name: "1l",cupSize: .large, selectedCupSize: $selectedDrinkSize)
        }
    }
}

struct CupSizeGroupView_Previews: PreviewProvider {
    static var previews: some View {
        CupSizeGroupView(selectedDrinkSize: .constant(.medium))
    }
}
