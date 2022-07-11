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
    @StateObject var champFetcher = ChampionFetcher()
    
    var body: some View {
        TabView {
            ChampionsView(champFetcher: champFetcher)
                .tabItem {
                    SwiftUI.Image("champIcon")
                        .renderingMode(.template)
                    Text("Champions")
                }
            RunesView()
                .tabItem {
                    SwiftUI.Image("runeIcon")
                        .renderingMode(.template)
                    Text("Runes")
                }
            SettingsView()
                .tabItem{
                    Label("Settings",systemImage: "gear")
                }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
        
    }
}


