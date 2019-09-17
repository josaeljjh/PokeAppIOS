//
//  PokedexModel.swift
//  PokeApp
//
//  Created by Josael Hernandez on 9/16/19.
//  Copyright © 2019 Josael Hernandez. All rights reserved.
//

import Foundation

// MARK: - PokedexModel
struct PokedexModel: Codable {
    let id: Int
    let locations: [MainGeneration]
    let mainGeneration: MainGeneration
    let name: String
    let names: [Name]
    let pokedexes, versionGroups: [MainGeneration]
    
    enum CodingKeys: String, CodingKey {
        case id, locations
        case mainGeneration = "main_generation"
        case name, names, pokedexes
        case versionGroups = "version_groups"
    }
    
    init(id: Int, locations: [MainGeneration], mainGeneration: MainGeneration, name: String, names: [Name], pokedexes: [MainGeneration], versionGroups: [MainGeneration]) {
        self.id = id
        self.locations = locations
        self.mainGeneration = mainGeneration
        self.name = name
        self.names = names
        self.pokedexes = pokedexes
        self.versionGroups = versionGroups
    }
}

// MARK: - MainGeneration
struct MainGeneration: Codable {
    let name: String
    let url: String
    
    init(name: String, url: String) {
        self.name = name
        self.url = url
    }
}

