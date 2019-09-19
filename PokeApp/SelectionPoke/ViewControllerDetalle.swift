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

class ViewControllerDetalle: UIViewController{
    
    @IBOutlet weak var imgPokemon: UIImageView!
    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var numero: UILabel!
    @IBOutlet weak var tipo: UILabel!
    @IBOutlet weak var region: UILabel!
    var pipeline = ImagePipeline.shared
    
    var sheetControllerDetalle: SheetViewController = SheetViewController()
    var datos = [PokemonEntry]()
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
        
        nombre.text = datos[0].pokemonSpecies.name
        numero.text = "\(datos[0].entryNumber)"
        
        //obtener imagen pokemon
        let urlPoke = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/"
        var img = datos[0].pokemonSpecies.url
        img = img.replacingOccurrences(of: "https://pokeapi.co/api/v2/pokemon-species/", with: "")
        img = img.replacingOccurrences(of: "/", with: "")+".png"
        img = urlPoke+img
        
        let url = URL(string:img)
        loadImage(url, imgPokemon)
        
    }
    
    @IBAction func cerrar(_ sender: Any) {
        sheetControllerDetalle.closeSheet()
    }
    
    @IBAction func agregar(_ sender: Any) {
        
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
