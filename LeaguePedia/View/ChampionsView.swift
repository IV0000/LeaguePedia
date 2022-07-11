//
//  ContentView.swift
//  LeaguePedia
//
//  Created by Ivan Voloshchuk on 03/01/22.
//

import SwiftUI

struct ChampionsView: View {
    
    @StateObject var manager = ChampionClass()
    
    var sortTypes = ["A-Z","Z-A",]
    @State private var searchText = ""
    @State private var selectedSort = 0
    
    var searchResults: [Datum] {
       
        if selectedSort == 1 {
            if !searchText.isEmpty {
                return manager.champion.filter({"\($0)".contains(searchText.capitalized)})
            }
            else {
                return manager.champion.sorted(by: {$0.name > $1.name})
            }
        }
        else {
            if !searchText.isEmpty {
                return manager.champion.filter({"\($0)".contains(searchText.capitalized)})
            }
            else {
                return manager.champion.sorted(by: {$0.name < $1.name})
            }
        }
    }
    
    var body: some View {
        NavigationView{
            VStack{
                ZStack{
                    List(searchResults, id:\.self){ champs in
                        NavigationLink(destination: ChampDetailView(champ:champs), label: {
                            HStack{
                                CacheAsyncImage(url : URL(string: "https://ddragon.leagueoflegends.com/cdn/12.1.1/img/champion/"+(champs.id)+".png")! ){ phase in
                                    if let image = phase.image {
                                        image.resizable()
                                            .clipped()
                                            .frame(width:100,height:100)
                                        
                                    }
                                    else if phase.error != nil {
                                        Color.red
                                            .frame(width: 100, height: 100)
                                        
                                    }
                                    else{
                                        ProgressView()
                                            .frame(width: 100, height: 100)
                                    }
                                }
                                
                                VStack(alignment: .leading) {
                                    Text(champs.name)
                                        .fontWeight(.bold)
                                        .foregroundColor(.primary)
                                    Text(champs.title)
                                        .fontWeight(.regular)
                                        .foregroundColor(.secondary)
                                }
                            }
                        })
                        
                    }
                    
                }
                .listStyle(.plain)
                .searchable(text: $searchText)
                .disableAutocorrection(true)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Picker(selection: $selectedSort, label: Text("Sort")) {
                            ForEach(0..<sortTypes.count, id: \.self) {
                                Text(self.sortTypes[$0])
                            }
                        }
                    }
                }
                
            }
            .navigationTitle("Champions")
            .onAppear{
                manager.loadData()}
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChampionsView()
    }
}
