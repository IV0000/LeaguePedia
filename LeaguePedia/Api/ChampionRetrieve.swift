//
//  ChampionRetrieve.swift
//  LeaguePedia
//
//  Created by Ivan Voloshchuk on 03/01/22.
//

import Foundation
import SwiftUI

@MainActor
class ChampionClass : ObservableObject {
    
    @Published var champion : [Datum] = []
    @AppStorage("version") private var version: String = ""
    
    init() {
        getVersion()
    }

    func getVersion() {
        guard let url = URL(string: "https://ddragon.leagueoflegends.com/api/versions.json") else {
            print("Invalid url...")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data{
                do{
                    let versions = try JSONDecoder().decode(Versions.self, from: data)
                    DispatchQueue.main.async {
                        self.version = versions.first ?? ""
                    }
                    print(self.version)
                }
                catch{
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    func loadData() {
        
        guard let url = URL(string: "https://ddragon.leagueoflegends.com/cdn/\(String(describing: version))/data/en_US/championFull.json") else {
            print("Invalid champion url")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
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
            
        }
        task.resume()
    }
}
