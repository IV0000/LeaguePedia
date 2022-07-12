//
//  ContentView.swift
//  LeaguePedia
//
//  Created by Ivan Voloshchuk on 03/01/22.
//

import SwiftUI

struct ChampionsView: View {
    
    @ObservedObject var champFetcher : ChampionFetcher
    
    var sortTypes = ["A-Z","Z-A"]
    @State private var searchText = ""
    @State private var selectedSort = 0
    
    var body: some View {
        NavigationView{
            VStack{
                if champFetcher.isChampLoading {
                    ProgressView()
                }
                else if champFetcher.errorMessage != nil {
                    Text(champFetcher.errorMessage ?? "An error occurred")
                }
                else{
                    List(champFetcher.filteredList, id:\.self){ champ in
                        NavigationLink(destination: ChampDetailView(champ:champ), label: {
                            ChampListRow(champ: champ)
                        })
                    }
                    .listStyle(.plain)
                }
            }
            .searchable(text: $champFetcher.searchText)
            .disableAutocorrection(true)
            .navigationTitle("Champions")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Picker(selection: $champFetcher.selectedSort, label: Text("Sort")) {
                        ForEach(0..<sortTypes.count, id: \.self) {
                            Text(self.sortTypes[$0])
                        }
                    }
                }
            }
        }
        .onAppear{champFetcher.loadChampData()}
    }
}


struct ChampListRow: View {
    
    var champ: Datum
    
    var body: some View {
        HStack{
            CacheAsyncImage(url : URL(string: "\(ddragon)/cdn/12.1.1/img/champion/"+(champ.id)+".png")! ){ phase in
                if let image = phase.image {
                    image.resizable()
                        .clipped()
                        .frame(width:80,height:80)
                }
                else if phase.error != nil {
                    Text("?")
                        .font(.system(size:40))
                        .fontWeight(.bold)
                        .frame(width: 80, height: 80)
                        .background(Color.red.opacity(0.6))
                }
                else{
                    ProgressView()
                        .frame(width: 80, height: 80)
                }
            }
            
            VStack(alignment: .leading) {
                Text(champ.name)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                Text(champ.title)
                    .fontWeight(.regular)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChampionsView(champFetcher: ChampionFetcher())
    }
}
