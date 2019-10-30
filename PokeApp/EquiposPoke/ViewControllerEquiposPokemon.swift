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
    
    @IBOutlet weak var imgFondo: UIImageView!
    @IBOutlet weak var listaEquipos: UITableView!
    @IBOutlet weak var tituloEquipos: UILabel!
    var dataSource = DataSourceEquipos()
    var spinner : JHSpinnerView!
    lazy var viewModel : ViewModelEquiposPoke = {
        let viewModel = ViewModelEquiposPoke(dataSource: dataSource)
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        imgFondo.visibility = .invisible
        // Loading
        spinner = Loading()
        view.addSubview(spinner)
        
        UpdateData()
        
        ObserverNotification()
    }
    
    func ObserverNotification() {
        //observer 
        NotificationCenter.default.addObserver(self, selector: #selector(onDidDetalleEquipo), name: .didDetalleEquipo, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onHideLoadig(_:)), name: .HideLoadig, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onOption(_:)), name: .didOption, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onUpdate(_:)), name: .didUpdate, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveError(_:)), name: .didReceiveError, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onReload(_:)), name: .didReload, object: nil)
    }
    
    @objc func onDidDetalleEquipo(_ notification:Notification) {
        if let data = notification.object as? Pokemon
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
    @objc func onOption(_ notification:Notification) {
        if let data = notification.object as? EquipoModel
        {
            SheetOption(data,listaEquipos)
            self.navigationController?.removeViewController(ViewControllerOption.self)
        }
        NotificationCenter.default.removeObserver(onOption)
        
    }
    @objc func onUpdate(_ notification:Notification) {
        //editar equipos
        if let data = notification.object as? EquipoModel
        {
            //pasar datos entre viewcontroller
            let selectionPoke = ViewControllerSelectionPoke.instantiate()
            selectionPoke.urlpokedex = data.urlRegion
            selectionPoke.nombreRegion = data.region
            selectionPoke.nombreEquipo = data.nombre
            selectionPoke.validar = true
            selectionPoke.mEquipoModel = [data]
            self.navigationController?.pushViewController(selectionPoke, animated: true)
            self.navigationController?.removeViewController(ViewControllerEquiposPokemon.self)
            
        }
        NotificationCenter.default.removeObserver(onUpdate)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func btnAtras(_ sender: Any) {
        //self.navigationController?.popViewController(animated: true)
        //InicialViewController("Region")
        navigationController?.popToViewController(ofClass: ViewControllerRegion.self)
        
    }
    
    @objc func onDidReceiveError(_ notification:Notification) {
        guard let mensaje = notification.userInfo?["msj"] as? String else { return }
        JNBBottombar.shared.show(text: mensaje)
        // Hide Loading
        spinner.dismiss()
        imgFondo.visibility = .visible
        NotificationCenter.default.removeObserver(onDidReceiveError)
    }
    
    func UpdateData(){
        //lista Equipos
        self.listaEquipos.delegate = self.dataSource
        
        // Do any additional setup after loading the view.
        self.listaEquipos.dataSource = self.dataSource
        self.dataSource.data.addAndNotify(observer: self) { [weak self] in
            self?.listaEquipos.reloadData()
        }
        //consulta equipos
        self.viewModel.getEquipos()
    }
    
    override func viewWillAppear(_ animated: Bool) {
       //UpdateData()
    }
    
    @objc func onReload(_ notification:Notification) {
     
     }
}
