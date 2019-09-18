//
//  CollectionDataSource.swift
//  PokeApp
//
//  Created by Josael Hernandez on 9/16/19.
//  Copyright © 2019 Josael Hernandez. All rights reserved.
//

import Foundation
import Nuke

class CollectionDataSource : GenericDataSource<PokemonEntry>,UICollectionViewDataSource,UICollectionViewDelegate{
    
    var arrData = [String]() // This is your data array
    var arrSelectedIndex = [IndexPath]() // This is selected cell Index array
    var arrSelectedData = [String]() // This is selected cell data array
    
    var pipeline = ImagePipeline.shared
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        //obtener imagen pokemon
        let urlPoke = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/"
        var imgPokemon = data.value[indexPath.row].pokemonSpecies.url
        imgPokemon = imgPokemon.replacingOccurrences(of: "https://pokeapi.co/api/v2/pokemon-species/", with: "")
        imgPokemon = imgPokemon.replacingOccurrences(of: "/", with: "")+".png"
        imgPokemon = urlPoke+imgPokemon
        
        let url = URL(string:imgPokemon)
        //cargar img con lib nuke
        // Nuke.loadImage(with: urlimg!, into: cell.imgHero)
        cell.textPoke.text = data.value[indexPath.row].pokemonSpecies.name.lowercased().capitalized
        loadImage(url, cell.ImgPoke)
        
        if arrSelectedIndex.contains(indexPath) { // You need to check wether selected index array contain current index if yes then change the color
            cell.cardView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            cell.imgBall.visibility = .visible
        }
        else {
            cell.cardView.backgroundColor = UIColor.white
            cell.imgBall.visibility = .invisible
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(data.value[indexPath.row].pokemonSpecies.name.lowercased().capitalized)
        let strData = data.value[indexPath.row].pokemonSpecies.name
        
        if arrSelectedIndex.contains(indexPath) {
            arrSelectedIndex = arrSelectedIndex.filter { $0 != indexPath}
            arrSelectedData = arrSelectedData.filter { $0 != strData}
        }
        else {
             if arrSelectedIndex.count <= 5 {
                arrSelectedIndex.append(indexPath)
                arrSelectedData.append(strData)
                print("\(arrSelectedIndex.count)")
             }else{
                 print("solo puedes elegir 6 pokemon")
            }
           
            
            if arrSelectedIndex.count >= 3 {
                if arrSelectedIndex.count <= 6 {
                  print("Guardar")
                }
            }else{
                print("No GUardar")
            }
        }
        
        collectionView.reloadData()
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

