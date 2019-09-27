//
//  PokemonDetalle.swift
//  PokeApp
//
//  Created by Josael Hernandez on 9/23/19.
//  Copyright © 2019 Josael Hernandez. All rights reserved.
//

import Foundation

// MARK: - PokemonDetalle
struct DetalleModel: Codable {
    let id: Int
    let name: String
    let eggGroups: [EggGroup]
   
    
    enum CodingKeys: String, CodingKey {
        case id,name
        case eggGroups = "egg_groups"
    }
    
    init(id: Int, name: String, eggGroups: [EggGroup]) {
        self.id = id
        self.name = name
        self.eggGroups = eggGroups
    }
}

// MARK: - Color
class EggGroup: Codable {
    let name: String
    let url: String
    
    init(name: String, url: String) {
        self.name = name
        self.url = url
    }
}
