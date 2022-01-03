//
//  ChampionRetrieve.swift
//  LeaguePedia
//
//  Created by Ivan Voloshchuk on 03/01/22.
//

import Foundation


@MainActor
class ChampionClass : ObservableObject {
    
    @Published var champion : [Datum] = []
    
    func loadData() {
        guard let url = URL(string: "https://ddragon.leagueoflegends.com/cdn/11.24.1/data/en_US/championFull.json") else {
            print("Invalid url...")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let data = data{
                
                do{
                    
                    let champion = try JSONDecoder().decode(Champion.self, from: data)
                    DispatchQueue.main.async {
                        self.champion = Array(champion.data.values)
                    }
                    //print(champion)
                }
                catch{
                    print(error)
                }
            }
            
        }.resume()
    }
}
