//
//  ViewModelEquiposList.swift
//  PokeApp
//
//  Created by Josael Hernandez on 10/14/19.
//  Copyright © 2019 Josael Hernandez. All rights reserved.
//

import Foundation


class ViewModelEquiposList{
    
    // we have to initialize the Dynamic var with the
    // data type we want
    weak var dataSource : GenericDataSource<ListPokemon>?
    //instancia de clase
    
    var data = [ListPokemon]()
    
    init(dataSource : GenericDataSource<ListPokemon>?) {
        self.dataSource = dataSource
    }
    
    func getList() {
        self.dataSource?.data.value = data
    }
}
