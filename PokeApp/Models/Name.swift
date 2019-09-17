//
//  Name.swift
//  PokeApp
//
//  Created by Josael Hernandez on 9/16/19.
//  Copyright © 2019 Josael Hernandez. All rights reserved.
//

import Foundation


// MARK: - Name
class Name: Codable {
    let language: MainGeneration
    let name: String
    
    init(language: MainGeneration, name: String) {
        self.language = language
        self.name = name
    }
}
