//
//  ViewControllerDetalle.swift
//  PokeApp
//
//  Created by Josael Hernandez on 9/18/19.
//  Copyright © 2019 Josael Hernandez. All rights reserved.
//

import Foundation
import UIKit
import Nuke
import FittedSheets

class ViewControllerDetalle: UIViewController{
    
    @IBOutlet weak var imgPokemon: UIImageView!
    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var numero: UILabel!
    @IBOutlet weak var tipo: UILabel!
    @IBOutlet weak var region: UILabel!
    var GridCollection: UICollectionView!
    @IBOutlet weak var btnAgregar: UIButton!
    var position:Int = 0
    var strData:String!
    var textRegion:String!
    var url:URL!
    var imgUrl:String!
    var pipeline = ImagePipeline.shared
    var valid = true
    var numeroString = ""
    var sheetControllerDetalle: SheetViewController = SheetViewController()
    var datos = [PokemonDetalle]()
    var equipo = [Pokemon]()
    /// - Returns: ViewController
    static func instantiate() -> ViewControllerDetalle {
        // swiftlint:disable force_cast
        return UIStoryboard(name: "Main",
                            bundle: nil)
            .instantiateViewController(withIdentifier: "Detalle") as! ViewControllerDetalle
    }
    
    //let controller = ViewControllerSelectionPoke.instantiate()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if(valid){
            nombre.text = datos[0].name.capitalized
            numero.text = "\(datos[0].id)"
            
            //obtener imagen pokemon
            //let urlPoke = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/"
            let urlPoke = "https://assets.pokemon.com/assets/cms2/img/pokedex/detail/"
            let numero = datos[0].id
            if(numero < 10){
                numeroString = "00\(numero)"
            }else if(numero < 100){
                numeroString = "0\(numero)"
            }else{
                numeroString = "\(numero)"
            }
            imgUrl = numeroString
            //img = img.replacingOccurrences(of: "https://pokeapi.co/api/v2/pokemon-species/", with: "")
            imgUrl = imgUrl.replacingOccurrences(of: "/", with: "")+".png"
            imgUrl = urlPoke+imgUrl
            
            url = URL(string:imgUrl)
            loadImage(url, imgPokemon)
            tipo.text = datos[0].eggGroups[0].name.capitalized
            region.text = textRegion.capitalized
        }else{
            btnAgregar.visibility = .invisible
            
            nombre.text = equipo[0].nombre.capitalized
            numero.text = equipo[0].numero
            url = URL(string:equipo[0].imagen)
            loadImage(url, imgPokemon)
            tipo.text = equipo[0].tipo.capitalized
            region.text = equipo[0].region.capitalized
        }
    }
    
    func seleccionPoke() {
        strData = datos[0].name.capitalized
        let indexPath = IndexPath(row: position, section: 0)
        
        if Globales.arrSelectedIndex.count <= 5 {
            Globales.arrSelectedIndex.append(indexPath)
            Globales.arrSelectedData.append(strData)
            //print("\(Globales.arrSelectedIndex.count)")
            
        }else{
            JNBBottombar.shared.show(text: "El maximo de pokémon para tu equipo es de 6.")
        }
        
        GridCollection.reloadData()
    }
    
    @IBAction func cerrar(_ sender: Any) {
        sheetControllerDetalle.closeSheet()
    }
    
    @IBAction func agregar(_ sender: Any) {
        sheetControllerDetalle.closeSheet()
        seleccionPoke()
        NotificationCenter.default.post(name: .didBtnSave, object: nil)
        let equipo = Pokemon(
            id: "\(position)",
            numero: numeroString,
            nombre: datos[0].name.capitalized,
            imagen: imgUrl,
            tipo: datos[0].eggGroups[0].name.capitalized,
            region: textRegion.capitalized
        )
        Globales.equipoPokemon.append(equipo)
        print("conteo: \(Globales.equipoPokemon.count)")
        // self.equipoPokemon.append(   id: "\(datos[0].id)",nombre: datos[0].name.capitalized,listPokemon:pokemon)
    }
    
}
