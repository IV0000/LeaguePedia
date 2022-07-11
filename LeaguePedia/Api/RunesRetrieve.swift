//
//  RunesRetrieve.swift
//  LeaguePedia
//
//  Created by Ivan Voloshchuk on 03/01/22.
//

import Foundation

class RuneClass : ObservableObject {
    
    @Published var runes : [MainRune] = []
    
    func loadRunesData() {
        
        guard let url = URL(string: "https://ddragon.leagueoflegends.com/cdn/12.12.1/data/en_US/runesReforged.json") else {
            print("Invalid url...")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let data = data{
                do{
                    let runes = try JSONDecoder().decode([MainRune].self, from: data)
                    DispatchQueue.main.async {
                        self.runes = runes
                    }
                    //print(runes)
                }
                catch{
                    print(error)
                }
            }
            
        }.resume()
    }
    
}
