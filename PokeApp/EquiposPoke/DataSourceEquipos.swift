//
//  DataSourceEquipos.swift
//  PokeApp
//
//  Created by Josael Hernandez on 9/27/19.
//  Copyright © 2019 Josael Hernandez. All rights reserved.
//
import UIKit
import GoogleSignIn

class DataSourceEquipos : GenericDataSource<EquipoModel>, UITableViewDataSource,UITableViewDelegate {

    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    
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
        header.imgOption.addTapClick{
            //self.controller.getDetalle()
            NotificationCenter.default.post(name: .didOption, object: titulo)
        }
        
        return header.contentView
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CellEquipos
        configurarCollection(cell, forRow: indexPath.section)
        //setCollectionViewDataSourceDelegate(cell, forRow: indexPath.row)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(data.value[indexPath.item].name.capitalized)
    }
    
    func configurarCollection(_ cell:CellEquipos, forRow section: Int) {
        
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
        
        cell.collectionList.delegate = cell
        cell.collectionList.dataSource = cell
        cell.lista = data.value[section].listPokemon

        cell.collectionList.reloadData()
     
    }
    
    
}
