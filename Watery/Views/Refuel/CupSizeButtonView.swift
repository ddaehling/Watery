//
//  CupSizeButtonView.swift
//  Watery
//
//  Created by Tom Stich on 25.11.20.
//

import SwiftUI

struct CupSizeButtonView: View {
    let name: String
    let cupSize: Size
    @Binding var selectedCupSize: Size
    
    var body: some View {
        HStack {
            Button(action: {
                selectedCupSize = cupSize
            }, label: {
                ZStack {
                    Circle()
                        .stroke(ColorManager.wateryBlue, lineWidth: cupSize == selectedCupSize ? 4 : 2)
                        .frame(width: 50, height: 50)
                        
                    
                    Text(name)
                }
            }).buttonStyle(PlainButtonStyle())
        }
    }
}

//struct CupSizeButtonView_Previews: PreviewProvider {
//    static var previews: some View {
//        CupSizeButtonView(name: "0.3", cupSize: .small, selectedCupSize: .small)
//    }
//}
