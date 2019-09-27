//
//  EquipoModel.swift
//  PokeApp
//
//  Created by Josael Hernandez on 9/23/19.
//  Copyright © 2019 Josael Hernandez. All rights reserved.
//

import Foundation

class EquipoModel: NSObject{
    let id: String
    let nombre: String
    let listPokemon: [Pokemon]
    
    init(id: String, nombre: String,listPokemon: [Pokemon]) {
        self.id = id
        self.nombre = nombre
        self.listPokemon = listPokemon
    }
}

class Pokemon: NSObject{
    var id: String
    var numero: String
    var nombre: String
    var imagen: String
    var tipo: String
    var region: String
    
     init(id: String,
         numero: String,
         nombre: String,
         imagen: String,
         tipo: String,
         region: String) {
        self.id = id
        self.numero = numero
        self.nombre = nombre
        self.imagen = imagen
        self.tipo = tipo
        self.region = region
    }
}
