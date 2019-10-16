//
//  DataSourceEquipos.swift
//  PokeApp
//
//  Created by Josael Hernandez on 9/27/19.
//  Copyright © 2019 Josael Hernandez. All rights reserved.
//

import Foundation
//
//  CurrencyDataSource.swift
//  PokeApp
//
//  Created by Josael Hernandez on 9/12/19.
//  Copyright © 2019 Josael Hernandez. All rights reserved.
//

import Foundation
import UIKit
import GoogleSignIn

class DataSourceEquipos : GenericDataSource<EquipoModel>, UITableViewDataSource,UITableViewDelegate  {
    
    var dataList = CollectionDataList()
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    
    lazy var viewModel : ViewModelEquiposList = {
        let viewModel = ViewModelEquiposList(dataSource: dataList)
        return viewModel
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.value.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           let header = tableView.dequeueReusableCell(withIdentifier: "headerEquipos") as! HeaderEquipos
        return header.bounds.height 
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let titulo = data.value[section]
        let header = tableView.dequeueReusableCell(withIdentifier: "headerEquipos") as! HeaderEquipos
        //header.textTitulo.text = "hola perros"
        header.setup(model: titulo)
        return header.contentView
    }
    
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CellEquipos
        
        self.viewModel.data = data.value[indexPath.section].listPokemon
        configurarCollection(cell)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(data.value[indexPath.item].name.capitalized)
    }
    
    func configurarCollection(_ cell:CellEquipos){
        
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        // Do any additional setup after loading the view, typically from a nib.
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        layout.itemSize = CGSize(width: (screenWidth/3) - 6, height: screenWidth/3)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        cell.collectionList.collectionViewLayout = layout
        
        //lista Equipos
        cell.collectionList.delegate = self.dataList
        
        // Do any additional setup after loading the view.
        cell.collectionList.dataSource = self.dataList
        //consulta regiones
        self.viewModel.getList()
    }
}
