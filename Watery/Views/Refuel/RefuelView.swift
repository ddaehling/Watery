//
//  RefuelView.swift
//  Watery
//
//  Created by Tom Stich on 25.11.20.
//

import SwiftUI


struct RefuelView: View {
    var selectedDrinkType = Water()
    @State var selectedDrinkSize: Size = .small
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Refuel yourself")
                .font(.title2).padding(.bottom, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            
            Text(selectedDrinkType.name)
                .font(.largeTitle)
                .foregroundColor(ColorManager.wateryBlue)
                .bold()
            
            HStack {
                CupSizeGroupView(selectedDrinkSize: $selectedDrinkSize)
            }
            
        }
        
    }
}

struct RefuelView_Previews: PreviewProvider {
    static var previews: some View {
        RefuelView()
    }
}
