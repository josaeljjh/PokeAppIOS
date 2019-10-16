//
//  EquiposPokemonViewController.swift
//  PokeApp
//
//  Created by Josael Hernandez on 9/27/19.
//  Copyright © 2019 Josael Hernandez. All rights reserved.
//

import Foundation
import UIKit


class ViewControllerEquiposPokemon: UIViewController{
    
    @IBOutlet weak var listaEquipos: UITableView!
    @IBOutlet weak var tituloEquipos: UILabel!
    
    let dataSource = DataSourceEquipos()
    
    lazy var viewModel : ViewModelEquiposPoke = {
        let viewModel = ViewModelEquiposPoke(dataSource: dataSource)
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view

        //lista Equipos
        self.listaEquipos.delegate = self.dataSource
        
        // Do any additional setup after loading the view.
        self.listaEquipos.dataSource = self.dataSource
        self.dataSource.data.addAndNotify(observer: self) { [weak self] in
            self?.listaEquipos.reloadData()
        }
        //consulta regiones
        self.viewModel.getEquipos()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
      }
    
    @IBAction func btnAtras(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
