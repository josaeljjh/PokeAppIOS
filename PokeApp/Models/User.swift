//
//  UserMOdel.swift
//  PokeApp
//
//  Created by Josael Hernandez on 10/28/19.
//  Copyright © 2019 Josael Hernandez. All rights reserved.
//

import Foundation

struct User: Codable {
    let idUser: String
    let userName: String
    let email: String
    let team: [EquipoModel]
    
    init(idUser: String,
            userName: String,
            email: String,
            team: [EquipoModel]) {
           self.idUser = idUser
           self.userName = userName
           self.email = email
           self.team = team
       }
}
