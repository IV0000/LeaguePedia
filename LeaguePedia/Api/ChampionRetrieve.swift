//
//  ChampionRetrieve.swift
//  LeaguePedia
//
//  Created by Ivan Voloshchuk on 03/01/22.
//

import Foundation
import SwiftUI

@MainActor
class ChampionFetcher: ObservableObject {
    // Fetching
    @Published var championsList: [Datum] = []
    @Published var isChampLoading: Bool = false
    @Published var errorMessage: String?
    @AppStorage("version") private var version: String = ""

    // Search & Filter
    @Published var searchText: String = ""
    @Published var selectedSort: Int = 0
    var filteredList: [Datum] {
        if selectedSort == 1 {
            if !searchText.isEmpty {
                return championsList.filter { "\($0)".contains(searchText.capitalized) }
            } else {
                return championsList.sorted(by: { $0.name > $1.name })
            }
        } else {
            if !searchText.isEmpty {
                return championsList.filter { "\($0)".contains(searchText.capitalized) }
            } else {
                return championsList.sorted(by: { $0.name < $1.name })
            }
        }
    }

    // Cache 10 minutes
    private let cache = InMemoryCache<[Datum]>(expirationInterval: 10 * 60)

    init() {
        getVersion()
    }

    // Get current patch version
    func getVersion() {
        let manager = ApiManager()
        let url = URL(string: "\(ddragon)/api/versions.json")
        manager.fetchAPI(Versions.self, url: url, completion: { [unowned self] result in
            DispatchQueue.main.async {
//                self.isChampLoading = false
                switch result {
                case let .failure(error):
                    self.errorMessage = error.userDescription
                    print(error.description)
                case let .success(versions):
                    self.version = versions.first ?? ""
                }
            }
        })
    }

    func loadChampData() {
        isChampLoading = true
        errorMessage = nil

        if let championsList = cache.value(forKey: "champs") {
            self.championsList = championsList
            isChampLoading = false
            print("cache HIT")
        } else {
            let manager = ApiManager()
            let url = URL(string: "\(ddragon)/cdn/\(String(describing: version))/data/\(ddlanguage)/championFull.json")
            manager.fetchAPI(Champion.self, url: url, completion: { [unowned self] result in
                DispatchQueue.main.async {
                    self.isChampLoading = false
                    switch result {
                    case let .failure(error):
                        self.errorMessage = error.userDescription
                        print(error.description)
                    case let .success(champion):
                        self.championsList = Array(champion.data.values)
                        self.cache.setValue(self.championsList, forKey: "champs")
                        print("cache set")
                    }
                }
            })
        }
    }
}
