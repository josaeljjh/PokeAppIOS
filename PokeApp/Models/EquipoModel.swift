//
//  EquipoModel.swift
//  PokeApp
//
//  Created by Josael Hernandez on 9/23/19.
//  Copyright © 2019 Josael Hernandez. All rights reserved.
//

import Foundation

struct EquipoModel: Codable {
    let idEquipo: String
    let nombre: String
    let urlRegion: String
    let region: String
    let listPokemon: [Pokemon]
}
