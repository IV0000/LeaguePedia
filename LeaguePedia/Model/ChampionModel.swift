//
//  ChampionModel.swift
//  LeaguePedia
//
//  Created by Ivan Voloshchuk on 03/01/22.
//

import Foundation

typealias Versions = [String]

// MARK: - Champion

struct Champion: Codable, Hashable {
    var type: TypeEnum
    var format: String
    var data: [String: Datum]
}

// MARK: - Datum

struct Datum: Codable, Hashable {
    // var version: String
    var id, key, name, title: String
    var lore: String
    var blurb: String
    var allytips: [String]
    var enemytips: [String]
    var info: Info
    var image: Image
    var tags: [String]
    var spells: [Spell]
    var passive: Passive
    var partype: String
    var stats: [String: Double]
}

// MARK: - Spell

struct Spell: Codable, Hashable {
    var id, name, spellDescription, tooltip: String
    var maxrank: Int
    var cooldown: [Float]
    var cost: [Int]
    var costBurn: String
    var costType, maxammo: String
    var image: Image
    var resource: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case spellDescription = "description"
        case tooltip, maxrank, cooldown, cost, costBurn, costType, maxammo, image, resource
    }
}

// MARK: - Passive

struct Passive: Codable, Hashable {
    var name: String
    var description: String
    var image: Image
}

// MARK: - Image

struct Image: Codable, Hashable {
    var full: String
    var sprite: String
    var group: String
    var x, y, w, h: Int
}

enum TypeEnum: String, Codable, Hashable {
    case champion
    case spell
}

// MARK: - Info

struct Info: Codable, Hashable {
    var attack, defense, magic, difficulty: Int
}
