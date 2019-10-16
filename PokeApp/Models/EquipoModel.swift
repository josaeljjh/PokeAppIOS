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
    let listPokemon: [ListPokemon]
}
struct ListPokemon: Codable {
       let id: String
       let imagen: String
       let nombre: String
       let numero: String
       let region: String
       let tipo: String
    
    init(id: String,
            imagen: String,
            nombre: String,
            numero: String,
            region: String,
            tipo: String) {
           self.id = id
           self.imagen = imagen
           self.nombre = nombre
           self.numero = numero
           self.region = region
           self.tipo = tipo
         
       }
   }
