//
//  Pokemon.swift
//  PokeApp
//
//  Created by Josael Hernandez on 10/2/19.
//  Copyright © 2019 Josael Hernandez. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
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
