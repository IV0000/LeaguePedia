//
//  ChampionRetrieve.swift
//  LeaguePedia
//
//  Created by Ivan Voloshchuk on 03/01/22.
//

import Foundation
import SwiftUI

var ddragon = "https://ddragon.leagueoflegends.com"
var ddlanguage = "en_US"

@MainActor
class ChampionFetcher : ObservableObject {
    
    @Published var championsList: [Datum] = []
    @Published var isChampLoading: Bool = false
    @Published var errorMessage: String?
    @AppStorage("version") private var version: String = ""
    
    init() {
        getVersion()
    }

    
    func getVersion() {
        
        let manager = ApiManager()
        let url = URL(string: "\(ddragon)/api/versions.json")
        manager.fetchAPI(Versions.self, url: url, completion: {[unowned self] result in
            DispatchQueue.main.async {
                self.isChampLoading = false
                switch result {
                case .failure(let error):
                    self.errorMessage = error.userDescription
                    print(error.description)
                case .success(let versions):
                    self.version = versions.first ?? ""
                }
            }
        })
    }
    
    func loadData() {
        
        isChampLoading = true
        errorMessage = nil
        
        let manager = ApiManager()
        let url = URL(string: "\(ddragon)/cdn/\(String(describing: version))/data/\(ddlanguage)/championFull.json")
        manager.fetchAPI(Champion.self, url: url, completion: {[unowned self] result in
            DispatchQueue.main.async {
                self.isChampLoading = false
                switch result {
                case .failure(let error):
                    self.errorMessage = error.userDescription
                    print(error.description)
                case .success(let champion):
                    self.championsList = Array(champion.data.values)
                }
            }
        })
    }
}
