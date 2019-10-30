//
//  ViewControllerSelectionPoke.swift
//  PokeApp
//
//  Created by Josael Hernandez on 9/13/19.
//  Copyright © 2019 Josael Hernandez. All rights reserved.
//

import Foundation
import UIKit
import Nuke
import FittedSheets
import Firebase
import FirebaseDatabase


class ViewControllerSelectionPoke: UIViewController{
    
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    @IBOutlet weak var Titulo: UILabel!
    @IBOutlet weak var GridCollection: UICollectionView!
    @IBOutlet weak var btnFloaty: LeftAlignedIconButton!
    @IBOutlet weak var edittEquipo: LeftAlignedIconEditt!
    @IBOutlet weak var btnAtras: UIButton!
    var spinner : JHSpinnerView!
    var urlpokedex : String!
    var nombreRegion : String!
    let dataSource = CollectionDataSource()
    var validar = false
    var mEquipoModel = [EquipoModel]()
    var id = ""
    var msj = ""
    var nombreEquipo = ""
    /// funcion de instancia para controlador
    ///
    /// - Returns: ViewControllerRegion
    static func instantiate() -> ViewControllerSelectionPoke {
        // swiftlint:disable force_cast
        return UIStoryboard(name: "Main",
                            bundle: nil)
            .instantiateViewController(withIdentifier: "Select") as! ViewControllerSelectionPoke
    }
    
    lazy var viewModel : ViewModelSelectionPoke = {
        let viewModel = ViewModelSelectionPoke(dataSource: dataSource,url:urlpokedex)
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ocultar botom save
        btnFloaty.visibility = .invisible
        //Nombre equipo
        edittEquipo.text = nombreEquipo
        
        // Loading
        spinner = Loading()
        view.addSubview(spinner)
        
        Titulo.text = "Región "+nombreRegion.capitalized
        //capturar tamaño de pantalla
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        // Do any additional setup after loading the view, typically from a nib.
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 1, left: 8, bottom: 10, right: 8)
        layout.itemSize = CGSize(width: (screenWidth/3) - 6, height: screenWidth/3)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        GridCollection!.collectionViewLayout = layout
        
        //lista pokemon
        self.GridCollection.delegate = self.dataSource
        
        // Do any additional setup after loading the view.
        self.GridCollection.dataSource = self.dataSource
        self.dataSource.data.addAndNotify(observer: self) { [weak self] in
            self?.GridCollection.reloadData()
        }
        
        //consulta regiones
        self.viewModel.getPokedex()
        
        ObserverNotification()
        
        ShowSheet(strings.titulo,strings.reglas)
        
    }
    
    func ObserverNotification() {
        //observer ERROR
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveError(_:)), name: .didReceiveError, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onHideLoadig(_:)), name: .HideLoadig, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveData(_:)), name: .didReceiveData, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onDidBtnSave(_:)), name: .didBtnSave, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveDetalle(_:)), name: .didReceiveDetalle, object: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
        
    }
    @IBAction func btnBack(_ sender: Any) {
        navigationController?.popToViewController(ofClass: ViewControllerRegion.self)
    }
    
    @objc func onDidReceiveError(_ notification:Notification) {
        guard let mensaje = notification.userInfo?["msj"] as? String else { return }
        JNBBottombar.shared.show(text: mensaje)
        // Hide Loading
        spinner.dismiss()
        NotificationCenter.default.removeObserver(onDidReceiveError)
    }
    @objc func onHideLoadig(_ notification:Notification) {
        // Hide Loading
        spinner.dismiss()
        NotificationCenter.default.removeObserver(onHideLoadig)
    }
    @objc func onDidReceiveData(_ notification:Notification) {
        if let data = notification.object as? PokemonEntry
        {
            guard let indexPath = notification.userInfo?["indexPath"] as? Int else { return }
            self.viewModel.getDetalle(data.pokemonSpecies.url,indexPath)
            
        }
        NotificationCenter.default.removeObserver(onDidReceiveData)
    }
    
    @objc func onDidReceiveDetalle(_ notification:Notification) {
        if let detalle = notification.object as? PokemonDetalle
        {
            guard let indexPath = notification.userInfo?["indexPath"] as? Int else { return }
            SheetDetalle(detalle,indexPath,self.GridCollection,nombreRegion)
            
        }
        NotificationCenter.default.removeObserver(onDidReceiveDetalle)
    }
    
    
    @objc func onDidBtnSave(_ notification:Notification) {
        if Globales.arrSelectedIndex.count >= 3 {
            if Globales.arrSelectedIndex.count <= 6 {
                print("Guardar")
                btnFloaty.visibility = .visible
                if Globales.arrSelectedIndex.count == 3 {
                    ShowHelp(btnFloaty,strings.tituloGuardar,strings.reglasGuardar,50)
                }
            }
        }else{
            btnFloaty.visibility = .invisible
            print("No GUardar")
        }
        NotificationCenter.default.removeObserver(onDidBtnSave)
    }
    
    @IBAction func save(_ sender: Any) {
        GuardarEquipo()
    }
    
    func GuardarEquipo() {
        if edittEquipo.text!.isEmpty{
            //showToast(message: "vacio")
            //JNBBottombar.shared.show(text: strings.nombreEquipo)
            ShowHelp(edittEquipo,strings.tituloEquipo,strings.nombreEquipo,60)
        }else{
            var dbRef: DatabaseReference!
            dbRef = Database.database().reference().child("User").child(Globales.idUser)
            if !validar {
                id = dbRef.childByAutoId().key ?? ""
                msj = "Equipo Agregado"
            }else{
                id = mEquipoModel[0].idEquipo
                msj = "Equipo Editado"
            }
            var arrayPoke = Array<[String:Any]>()
            for poke in Globales.equipoPokemon{
                let pokemon = ["id": poke.id,"numero":poke.numero,"nombre":poke.nombre,"imagen":poke.imagen,"tipo":poke.tipo,"region":poke.region] as [String : Any]
                arrayPoke.append(pokemon)
            }
            //crear
            let equipo = [
                "idEquipo": id,
                "nombre": edittEquipo.text! as String,
                "urlRegion": urlpokedex as String,
                "region": nombreRegion as String,
                "listPokemon": arrayPoke
                ] as [String : Any]
            
            dbRef.child("team").child(id).setValue(equipo)
            
            JNBBottombar.shared.show(text: msj)
            starViewController("Equipos")
            self.navigationController?.removeViewController(ViewControllerSelectionPoke.self)
            
        }
    }
}
