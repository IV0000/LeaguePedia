//
//  ContentView.swift
//  LeaguePedia
//
//  Created by Ivan Voloshchuk on 03/01/22.
//

import SwiftUI

struct ChampionsView: View {
    
    @ObservedObject var champFetcher : ChampionFetcher
    
    var sortTypes = ["A-Z","Z-A",]
    @State private var searchText = ""
    @State private var selectedSort = 0
    
    var filteredList: [Datum] {
        
        if selectedSort == 1 {
            if !searchText.isEmpty {
                return champFetcher.championsList.filter({"\($0)".contains(searchText.capitalized)})
            }
            else {
                return champFetcher.championsList.sorted(by: {$0.name > $1.name})
            }
        }
        else {
            if !searchText.isEmpty {
                return champFetcher.championsList.filter({"\($0)".contains(searchText.capitalized)})
            }
            else {
                return champFetcher.championsList.sorted(by: {$0.name < $1.name})
            }
        }
    }
    
    var body: some View {
        NavigationView{
            VStack{
                ZStack{
                    List(filteredList, id:\.self){ champs in
                        NavigationLink(destination: ChampDetailView(champ:champs), label: {
                            HStack{
                                CacheAsyncImage(url : URL(string: "\(ddragon)/cdn/12.1.1/img/champion/"+(champs.id)+".png")! ){ phase in
                                    if let image = phase.image {
                                        image.resizable()
                                            .clipped()
                                            .frame(width:100,height:100)
                                        
                                    }
                                    else if phase.error != nil {
                                        Text("?")
                                            .font(.system(size:40))
                                            .fontWeight(.bold)
                                            .frame(width: 100, height: 100)
                                            .background(Color.red.opacity(0.6))
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
                champFetcher.loadData()}
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChampionsView(champFetcher: ChampionFetcher())
    }
}
