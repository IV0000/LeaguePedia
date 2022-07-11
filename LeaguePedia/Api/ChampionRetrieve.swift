//
//  ChampionRetrieve.swift
//  LeaguePedia
//
//  Created by Ivan Voloshchuk on 03/01/22.
//

import Foundation
import SwiftUI

@MainActor
class ChampionFetcher : ObservableObject {
    
    //Fetching
    @Published var championsList: [Datum] = []
    @Published var isChampLoading: Bool = false
    @Published var errorMessage: String?
    @AppStorage("version") private var version: String = ""
    
    //Search & Filter
    @Published var searchText: String = ""
    @Published var selectedSort: Int = 0
    var filteredList: [Datum] {
        if selectedSort == 1 {
            if !searchText.isEmpty {
                return championsList.filter({"\($0)".contains(searchText.capitalized)})
            }
            else {
                return championsList.sorted(by: {$0.name > $1.name})
            }
        }
        else {
            if !searchText.isEmpty {
                return championsList.filter({"\($0)".contains(searchText.capitalized)})
            }
            else {
                return championsList.sorted(by: {$0.name < $1.name})
            }
        }
    }
    
    init() {
        getVersion()
    }
    
    //Get current patch version
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
    
    func loadChampData() {
        
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
