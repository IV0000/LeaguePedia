//
//  ContentView.swift
//  LeaguePedia
//
//  Created by Ivan Voloshchuk on 03/01/22.
//

import SwiftUI

struct ChampionsView: View {
    
    @StateObject var manager = ChampionClass()
    @State private var searchText = ""
    
    //For SearchField
    var searchResults : [Datum]{
        if searchText.isEmpty {
            return manager.champion.sorted(by: {$0.name < $1.name})
        }
        else{
            return manager.champion.filter({"\($0)".contains(searchText.capitalized)})
        }
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                List(searchResults, id:\.self){champs in
                    NavigationLink(destination: ChampDetailView(champ:champs), label:{
                        HStack{
                            CacheAsyncImage(url : URL(string: "https://ddragon.leagueoflegends.com/cdn/11.24.1/img/champion/"+(champs.id)+".png")! ){phase in
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
                            
                            VStack(alignment: .leading){
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
                
            }.navigationTitle("Champions")
            .listStyle(.plain)
                .searchable(text: $searchText)
        }
            .onAppear{
                manager.loadData()}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChampionsView()
    }
}
