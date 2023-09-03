//
//  SuperheroModel.swift
//  Superhero-API-iOS
//
//  Created by Guilherme Antonini on 03/09/23.
//

import Foundation

enum SuperHeroID: String {
    case antMan
    case antiVenom
    case aquaman
    case batgirl
    case batman
    case bumblebee
    case captainAmerica
    case captainMarvel
    case flash
    case gamora
    
    public var description: String {
        switch self {
        case .antMan:
            return "30"
        case .antiVenom:
            return "34"
        case .aquaman:
            return "38"
        case .batgirl:
            return "63"
        case .batman:
            return "69"
        case .bumblebee:
            return "142"
        case .captainAmerica:
            return "149"
        case .captainMarvel:
            return "156"
        case .flash:
            return "263"
        case .gamora:
            return "275"
        }
    }
    
}

struct SuperHeroImage: Decodable {
    var url: String
    
    init() {
        self.url = ""
    }
    
    init(url: String) {
        self.url = url
    }
}

struct PowerStats: Decodable {
    enum CodingKeys: String, CodingKey {
        case intelligence, strength, speed, durability, power, combat
    }
    
    var intelligence: String
    var strength: String
    var speed: String
    var durability: String
    var power: String
    var combat: String
    
    init() {
        self.intelligence = ""
        self.strength = ""
        self.speed = ""
        self.durability = ""
        self.power = ""
        self.combat = ""
    }
    
    init(intelligence: String, strength: String, speed: String,
         durability: String, power: String, combat: String) {
        self.intelligence = intelligence
        self.strength = strength
        self.speed = speed
        self.durability = durability
        self.power = power
        self.combat = combat
    }
}

struct Biography: Decodable {
    enum CodingKeys: String, CodingKey {
        case publisher, alignment
        case fullName = "full-name"
        case alterEgos = "alter-egos"
        case placeOfBirth = "place-of-birth"
        case firstAppearance = "first-appearance"
    }
    
    var fullName: String
    var alterEgos: String
    var placeOfBirth: String
    var firstAppearance: String
    var publisher: String
    var alignment: String
    
    init() {
        self.fullName = ""
        self.alterEgos = ""
        self.placeOfBirth = ""
        self.firstAppearance = ""
        self.publisher = ""
        self.alignment = ""
    }
    
    init(fullName: String, alterEgos: String, placeOfBirth: String,
         firstAppearance: String, publisher: String, alignment: String) {
        self.fullName = fullName
        self.alterEgos = alterEgos
        self.placeOfBirth = placeOfBirth
        self.firstAppearance = firstAppearance
        self.publisher = publisher
        self.alignment = alignment
    }
}

struct SuperheroModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case name, biography, image
        case powerStats = "powerstats"
    }
    
    var name: String
    var powerstats: PowerStats
    var biography: Biography
    var image: SuperHeroImage
    
    init() {
        self.name = ""
        self.powerstats = PowerStats()
        self.biography = Biography()
        self.image = SuperHeroImage()
    }
    
    init(name: String, powerStats: PowerStats, biography: Biography, image: SuperHeroImage) {
        self.name = name
        self.powerstats = powerStats
        self.biography = biography
        self.image = image
    }
    
    init(from decoder: Decoder) throws {
        let decoder = try decoder.container(keyedBy: CodingKeys.self)
        name = try decoder.decode(String.self, forKey: .name)
        powerstats = try decoder.decode(PowerStats.self, forKey: .powerStats)
        biography = try decoder.decode(Biography.self, forKey: .biography)
        image = try decoder.decode(SuperHeroImage.self, forKey: .image)
    }
}
