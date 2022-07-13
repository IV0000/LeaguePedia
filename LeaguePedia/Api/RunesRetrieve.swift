//
//  RunesRetrieve.swift
//  LeaguePedia
//
//  Created by Ivan Voloshchuk on 03/01/22.
//

import Foundation

class RuneFetcher: ObservableObject {
    
    @Published var runesList: [MainRune] = []
    @Published var isRunesLoading: Bool = false
    @Published var errorMessage: String?
        
    func loadRunesData() {
        
        isRunesLoading = true
        errorMessage = nil
        
        let manager = ApiManager()
        let url = URL(string: "\(ddragon)/cdn/12.12.1/data/\(ddlanguage)/runesReforged.json")
        manager.fetchAPI([MainRune].self, url: url, completion: {[unowned self] result in
            DispatchQueue.main.async {
                self.isRunesLoading = false
                switch result {
                case .failure(let error):
                    self.errorMessage = error.userDescription
                    print(error.description)
                case .success(let rune):
                    self.runesList = rune
                }
            }
        })
    }
}
