//
//  BarView.swift
//  Watery
//
//  Created by Daniel Dähling on 29.11.20.
//

import SwiftUI

struct BarView: View {
    
    var value: Double
    var cornerRadius: CGFloat
    
    var body: some View {
        VStack {
            ZStack (alignment: .bottom) {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .frame(width: 25, height: 200)
                    .foregroundColor(.white)
                RoundedRectangle(cornerRadius: cornerRadius)
                    .frame(width: 25, height: CGFloat(value))
                    .foregroundColor(ColorManager.wateryBlue)
            }
            .padding(.bottom, 8)
        }
    }
}

struct BarView_Previews: PreviewProvider {
    static var previews: some View {
        BarView(value: 10, cornerRadius: 10)
    }
}
