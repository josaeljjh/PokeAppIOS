//
//  PokemonModel.swift
//  PokeApp
//
//  Created by Josael Hernandez on 9/16/19.
//  Copyright © 2019 Josael Hernandez. All rights reserved.
//

import Foundation

// MARK: - PokemonModel
struct PokemonModel: Codable {
    let id: Int
    let name: String
    let names: [Name]
    let versionGroups: [Region]
    let descriptions: [Description]
    let isMainSeries: Bool
    let pokemonEntries: [PokemonEntry]
    let region: Region
    
    enum CodingKeys: String, CodingKey {
        case id, name, names
        case versionGroups = "version_groups"
        case descriptions
        case isMainSeries = "is_main_series"
        case pokemonEntries = "pokemon_entries"
        case region
    }
    
    init(id: Int, name: String, names: [Name], versionGroups: [Region], descriptions: [Description], isMainSeries: Bool, pokemonEntries: [PokemonEntry], region: Region) {
        self.id = id
        self.name = name
        self.names = names
        self.versionGroups = versionGroups
        self.descriptions = descriptions
        self.isMainSeries = isMainSeries
        self.pokemonEntries = pokemonEntries
        self.region = region
    }
}

// MARK: - Description
struct Description: Codable {
    let descriptionDescription: String
    let language: Region
    
    enum CodingKeys: String, CodingKey {
        case descriptionDescription = "description"
        case language
    }
    
    init(descriptionDescription: String, language: Region) {
        self.descriptionDescription = descriptionDescription
        self.language = language
    }
}

// MARK: - Region
struct Region: Codable {
    let name: String
    let url: String
    
    init(name: String, url: String) {
        self.name = name
        self.url = url
    }
}

// MARK: - PokemonEntry
struct PokemonEntry: Codable {
    let entryNumber: Int
    let pokemonSpecies: Region
    
    enum CodingKeys: String, CodingKey {
        case entryNumber = "entry_number"
        case pokemonSpecies = "pokemon_species"
    }
    
    init(entryNumber: Int, pokemonSpecies: Region) {
        self.entryNumber = entryNumber
        self.pokemonSpecies = pokemonSpecies
    }
}
