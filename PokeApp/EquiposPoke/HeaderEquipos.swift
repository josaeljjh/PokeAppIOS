//
//  HeaderEquipos.swift
//  PokeApp
//
//  Created by Josael Hernandez on 10/14/19.
//  Copyright © 2019 Josael Hernandez. All rights reserved.
//
import UIKit

class HeaderEquipos: UITableViewCell{
    @IBOutlet weak var textTitulo: UILabel!
    @IBOutlet weak var imgOption: UIImageView!
    
    func setup(model: EquipoModel) {
        textTitulo.text = model.nombre
    }
}
