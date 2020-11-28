//
//  ContainerView.swift
//  Watery
//
//  Created by Tom Stich on 26.11.20.
//

import SwiftUI

struct ContainerView<Content>: View where Content: View {
    let content: () -> Content
    
    init(@ViewBuilder _ content: @escaping () -> Content) {
          self.content = content
  }
    
    var body: some View {
        HStack(alignment: .center ){
            ZStack {
                Rectangle()
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.size.width/1.10)
                    .cornerRadius(15)
                    .shadow(radius: 2)
                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, 5)
                
                content().padding(20)
            }
        }
    }
}

struct ContainerView_Previews: PreviewProvider {
    static var previews: some View {
        ContainerView() {
            Text("asd")
        }
            .previewLayout(.sizeThatFits)
    }
}
