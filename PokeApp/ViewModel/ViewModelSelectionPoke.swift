//
//  ViewModelSelectionPoke.swift
//  PokeApp
//
//  Created by Josael Hernandez on 9/13/19.
//  Copyright © 2019 Josael Hernandez. All rights reserved.
//

import Foundation
import UIKit
import GoogleSignIn
import Alamofire

class ViewModelSelectionPoke{
    
    // we have to initialize the Dynamic var with the
    // data type we want
    weak var dataSource : GenericDataSource<PokemonEntry>?
    //instancia de clase
    var region = [PokedexModel]()
    var pokemon = [PokemonModel]()
    var item = [PokemonEntry]()
    var urlPokedex : String!
    var valid : Bool!
    
    init(dataSource : GenericDataSource<PokemonEntry>?,url:String) {
        self.dataSource = dataSource
        self.urlPokedex = url
    }

    func getPokedex() {
        //url
        let url = URL(string: urlPokedex)
        //descarga de datos
        Alamofire.request(url!).responseJSON { (response) in
            switch response.result{
            case .success:
                do{
                    //self.heroes =  try JSONDecoder().decode([Hero].self, from: response.data!)
                    self.region = [try JSONDecoder().decode(PokedexModel.self, from: response.data!)]
                    if(!self.region[0].pokedexes.isEmpty){
                       self.getPokemon(self.region[0].pokedexes[0].url)
                    }else{
                
                    NotificationCenter.default.post(name: .didReceiveData, object: nil)
                    }
                }catch let JSON_error{
                    print("error",JSON_error)
                }
            case.failure(let error):
                print(error)
            }
        }
    }
    
    func getPokemon(_ urlPoke: String) {
        //url
        let url = URL(string:urlPoke)
        //descarga de datos
        Alamofire.request(url!).responseJSON { (response) in
            switch response.result{
            case .success:
                do{
                    //self.heroes =  try JSONDecoder().decode([Hero].self, from: response.data!)
                    self.pokemon = [try JSONDecoder().decode(PokemonModel.self, from: response.data!)]
                    self.valid = true
                    self.dataSource?.data.value = self.pokemon[0].pokemonEntries
                    self.item = self.pokemon[0].pokemonEntries
                    //for prueba in region{
                    //  self.dataSource?.data.value = prueba.results
                    //}
                }catch let JSON_error{
                    print("error",JSON_error)
                }
            case.failure(let error):
                print(error)
            }
        }
    }
    

    
}
