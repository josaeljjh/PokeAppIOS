//
//  CellEquipos.swift
//  PokeApp
//
//  Created by Josael Hernandez on 9/27/19.
//  Copyright © 2019 Josael Hernandez. All rights reserved.
//

import Foundation
import UIKit
import Nuke

class CellEquipos: UITableViewCell,UICollectionViewDataSource,UICollectionViewDelegate {
    
    @IBOutlet weak var collectionList: UICollectionView!
    var pipeline = ImagePipeline.shared
    var lista = [ListPokemon]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lista.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellList", for: indexPath) as! CellListEquipos
        
        //obtener imagen pokemon
        let url = URL(string:lista[indexPath.row].imagen)
        //cargar img con lib nuke
        loadImage(url, cell.imgPokeE)
        cell.textPokeE.text = lista[indexPath.row].nombre.lowercased().capitalized
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //print(data.value[indexPath.row].pokemonSpecies.name.lowercased().capitalized)
        //click
        let datos = lista[indexPath.row]
        NotificationCenter.default.post(name: .didDetalleEquipo, object: datos)

    }
    
    func loadImage(_ urlimg: URL?,_ image: UIImageView) {
        
        let screenWidth = UIScreen.main.bounds.size.width / 3
        let targetSize = CGSize(width: screenWidth, height: (screenWidth * 2 / 3))
        
        let request = ImageRequest(
            url: urlimg!,
            processors: [
                ImageProcessor.Resize(size: targetSize),
                ImageProcessor.Circle()
            ]
        )
        
        var options = ImageLoadingOptions(transition: .fadeIn(duration: 0.5))
        options.pipeline = pipeline
        
        Nuke.loadImage(with: request, options: options, into:image)
    }
}

