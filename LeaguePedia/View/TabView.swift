//
//  TabView.swift
//  LeaguePedia
//
//  Created by Ivan Voloshchuk on 05/01/22.
//

import SwiftUI

struct Tab: View {
    
    @State private var selection = "Champions"
    
    var body: some View {
        //        TabView {
        //            ChampionsView()
        //                .tabItem {
        //                    Label("Champions", systemImage: "list.dash")
        //                }
        //
        //            RunesView()
        //                .tabItem {
        //                    Label("Runes", systemImage: "square.and.pencil")
        //                }
        //        }
        
        
        NavigationView {
            TabView(selection: $selection) {
                ChampionsView()
                    .tag("Champions")
                    .tabItem {
                        SwiftUI.Image(systemName: "list.dash")
                        Text("Champions")
                    }
                RunesView()
                    .tag("Runes")
                    .tabItem {
                        SwiftUI.Image(systemName: "square.and.pencil")
                        Text("Runes")
                    }
            }
            .navigationBarTitle(self.selection)
        }
        
    }
}


