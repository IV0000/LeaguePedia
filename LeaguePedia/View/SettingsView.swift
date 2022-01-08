//
//  SettingsView.swift
//  LeaguePedia
//
//  Created by Ivan Voloshchuk on 07/01/22.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    @State var index = 0
    let languages = ["English","Italian"]
    
    var body: some View {
        NavigationView{
            VStack{
                List{
                    Toggle(isOn: $isDarkMode) {
                        ZStack{
                            Rectangle()
                                .frame(width: 36, height: 36)
                                .cornerRadius(10)
                                .foregroundColor(.blue)
                            SwiftUI.Image(systemName:"sun.max")
                        }
                        Text("Dark Mode")
                            .fontWeight(.semibold)
                    }
                    HStack{
                        ZStack{
                            Rectangle()
                                .frame(width: 36, height: 36)
                                .cornerRadius(10)
                                .foregroundColor(.red)
                            SwiftUI.Image(systemName:"flag")
                        }
                        Text("Language")
                            .fontWeight(.semibold)
                    }
                }.listStyle(.plain)
                Spacer()
            }.navigationTitle("Settings")
                .padding()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
