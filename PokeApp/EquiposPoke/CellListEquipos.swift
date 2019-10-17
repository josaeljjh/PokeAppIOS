//
//  CellListEquipos.swift
//  PokeApp
//
//  Created by Josael Hernandez on 10/7/19.
//  Copyright © 2019 Josael Hernandez. All rights reserved.
//

import Foundation
import UIKit

class CellListEquipos: UICollectionViewCell{
    @IBOutlet weak var imgPokeE: UIImageView!
    @IBOutlet weak var textPokeE: UILabel!
    
    
    func setup(model: ListPokemon) {
        textPokeE.text = model.nombre
    }
}
