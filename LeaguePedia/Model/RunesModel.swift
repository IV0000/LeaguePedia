//
//  RunesModel.swift
//  LeaguePedia
//
//  Created by Ivan Voloshchuk on 03/01/22.
//

import Foundation

// struct RuneData: Codable,Hashable {
//    var mainRune: [MainRune]
// }

struct MainRune: Codable, Hashable {
    var id: Int
    var key, icon, name: String
    var slots: [Slot]
}

struct Slot: Codable, Hashable {
    var runes: [Rune]
}

struct Rune: Codable, Hashable {
    var id: Int
    var key: String
    var icon: String
    var name: String
    var shortDesc: String
    var longDesc: String
}
