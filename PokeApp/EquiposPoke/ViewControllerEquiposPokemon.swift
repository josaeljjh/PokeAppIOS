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
    var spinner:JHSpinnerView!
    let dataSource = DataSourceEquipos()
    
    lazy var viewModel : ViewModelEquiposPoke = {
        let viewModel = ViewModelEquiposPoke(dataSource: dataSource)
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        
        // Loading
        spinner = JHSpinnerView.showOnView(view, spinnerColor:#colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1), overlay:.custom(CGSize(width: 150, height: 130), 20), overlayColor:UIColor.black.withAlphaComponent(0.6), fullCycleTime:4.0, text:"Loading")
        
        view.addSubview(spinner)
        
        //lista Equipos
        self.listaEquipos.delegate = self.dataSource
        
        // Do any additional setup after loading the view.
        self.listaEquipos.dataSource = self.dataSource
        self.dataSource.data.addAndNotify(observer: self) { [weak self] in
            self?.listaEquipos.reloadData()
        }
        //consulta regiones
        self.viewModel.getEquipos()
        
        ObserverNotification()
    }
    
    func ObserverNotification() {
        //observer 
        NotificationCenter.default.addObserver(self, selector: #selector(onDidDetalleEquipo), name: .didDetalleEquipo, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onHideLoadig(_:)), name: .HideLoadig, object: nil)
    }
    @objc func onDidDetalleEquipo(_ notification:Notification) {
        if let data = notification.object as? ListPokemon
        {
            SheetDetalleEquipo(data)
        }
        
        NotificationCenter.default.removeObserver(onDidDetalleEquipo)
    }
    @objc func onHideLoadig(_ notification:Notification) {
        // Hide Loading
        spinner.dismiss()
        NotificationCenter.default.removeObserver(onHideLoadig)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func btnAtras(_ sender: Any) {
        //self.navigationController?.popViewController(animated: true)
        //self.navigationController?.popToRootViewController(animated: true)
        //InicialViewController("Region")
        navigationController?.popToViewController(ofClass: ViewControllerRegion.self)
    }
}
