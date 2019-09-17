//
//  ViewModelSocialLogin.swift
//  PokeApp
//
//  Created by Josael Hernandez on 9/12/19.
//  Copyright © 2019 Josael Hernandez. All rights reserved.
//

import Foundation
import UIKit
import GoogleSignIn
import Alamofire

class ViewModelRegion{

// we have to initialize the Dynamic var with the
// data type we want
weak var dataSource : GenericDataSource<Result>?
//instancia de clase
var region = [RegionModel]()
var item = [Result]()

init(dataSource : GenericDataSource<Result>?) {
    self.dataSource = dataSource
}

func getRegion() {
    //url
    let url = URL(string:"https://pokeapi.co/api/v2/region/")
    //descarga de datos
    Alamofire.request(url!).responseJSON { (response) in
        switch response.result{
        case .success:
            do{
                //self.heroes =  try JSONDecoder().decode([Hero].self, from: response.data!)
                self.region = [try JSONDecoder().decode(RegionModel.self, from: response.data!)]
                self.dataSource?.data.value = self.region[0].results
                self.item = self.region[0].results
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
