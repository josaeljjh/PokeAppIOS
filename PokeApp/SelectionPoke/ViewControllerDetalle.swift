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
    var position:Int = 0
    var strData:String!
    var textRegion:String!
    var url:URL!
    var imgUrl:String!
    var pipeline = ImagePipeline.shared
    
    var sheetControllerDetalle: SheetViewController = SheetViewController()
    var datos = [PokemonDetalle]()
    /// - Returns: ViewControllerRegion
    static func instantiate() -> ViewControllerDetalle {
        // swiftlint:disable force_cast
        return UIStoryboard(name: "Main",
                            bundle: nil)
            .instantiateViewController(withIdentifier: "Detalle") as! ViewControllerDetalle
    }
    
    //let controller = ViewControllerSelectionPoke.instantiate()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nombre.text = datos[0].name.capitalized
        numero.text = "\(datos[0].id)"
        
        //obtener imagen pokemon
        let urlPoke = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/"
        imgUrl = "\(datos[0].id)"
        //img = img.replacingOccurrences(of: "https://pokeapi.co/api/v2/pokemon-species/", with: "")
        imgUrl = imgUrl.replacingOccurrences(of: "/", with: "")+".png"
        imgUrl = urlPoke+imgUrl
        
        url = URL(string:imgUrl)
        loadImage(url, imgPokemon)
        tipo.text = datos[0].eggGroups[0].name.capitalized
        region.text = textRegion.capitalized
        
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
                        numero: "\(datos[0].id)",
                        nombre: datos[0].name.capitalized,
                        imagen: imgUrl,
                        tipo: datos[0].eggGroups[0].name.capitalized,
                        region: textRegion.capitalized
                        )
            Globales.equipoPokemon.append(equipo)
            print("conteo: \(Globales.equipoPokemon.count)")
        // self.equipoPokemon.append(   id: "\(datos[0].id)",nombre: datos[0].name.capitalized,listPokemon:pokemon)
    }
    func loadImage(_ urlimg: URL?,_ image: UIImageView) {
        
        let screenWidth = UIScreen.main.bounds.size.width / 3
        let targetSize = CGSize(width: screenWidth, height: (screenWidth * 2 / 3))
        
        let request = ImageRequest(
            url: urlimg!,
            processors: [
                ImageProcessor.Resize(size: targetSize)
            ]
        )
        
        var options = ImageLoadingOptions(transition: .fadeIn(duration: 0.5))
        options.pipeline = pipeline
        
        Nuke.loadImage(with: request, options: options, into:image)
    }
}
