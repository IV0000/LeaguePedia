//
//  TabView.swift
//  LeaguePedia
//
//  Created by Ivan Voloshchuk on 05/01/22.
//

import SwiftUI

struct Tab: View {
    
    init() {
        UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().barTintColor = UIColor(named: "cardColor")
    }
    
    
    @State private var selection = "Champions"
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
                TabView {
                    ChampionsView()
                        .tabItem {
                            Label("Champions",systemImage: "camera.filters")
                        }
        
                    RunesView()
                        .tabItem {
                            SwiftUI.Image("runesTab")
                                .renderingMode(.template)
                            Text("Runes")
                        }
                     SettingsView()
                        .tabItem{
                            Label("Settings",systemImage: "gear")
                        }
                }.preferredColorScheme(isDarkMode ? .dark : .light)
        
        
        //TAB WITH PROBLEMS
        
//        NavigationView {
//            TabView(selection: $selection) {
//                ChampionsView()
//                    .tag("Champions")
//                    .tabItem {
//                        SwiftUI.Image(systemName: "list.dash")
//                        Text("Champions")
//                    }
//                RunesView()
//                    .tag("Runes")
//                    .tabItem {
//                        SwiftUI.Image(systemName: "square.and.pencil")
//                        Text("Runes")
//                    }
//            }
//            .navigationBarTitle(self.selection)
//        }
        
    }
}


