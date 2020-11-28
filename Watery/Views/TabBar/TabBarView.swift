//
//  TabBarView.swift
//  Watery
//
//  Created by Tom Stich on 26.11.20.
//

import SwiftUI
import ComposableArchitecture

struct TabBarView: View {
    
    var body: some View {
        TabView {
            MainView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Main")
                }
                .tag(0)
            MainView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
                .tag(1)
            MainView()
                .tabItem {
                    Image(systemName: "plus")
                    Text("WateryPro")
                }
                .tag(2)
            
        }.accentColor(ColorManager.wateryBlue)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
