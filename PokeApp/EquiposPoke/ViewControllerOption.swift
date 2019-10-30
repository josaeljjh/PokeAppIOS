//
//  ViewControllerHeader.swift
//  PokeApp
//
//  Created by Josael Hernandez on 10/15/19.
//  Copyright © 2019 Josael Hernandez. All rights reserved.
//

import Foundation
import UIKit
import FittedSheets
import TKFormTextField
import Firebase
import FirebaseDatabase

class ViewControllerOption: UIViewController{
    
    @IBOutlet weak var Contenedor: UIView!
    @IBOutlet weak var textOption: UILabel!
    @IBOutlet weak var editTeam: TKFormTextField!
    @IBOutlet weak var btnRenombrar: LeftAlignedIconButton!
    var listaPoke:UITableView!
    
    var mEquipoModel = [EquipoModel]()
    var dbRef: DatabaseReference!
    
    var sheetControllerOption: SheetViewController = SheetViewController()
    
    /// - Returns: ViewController
    static func instantiate() -> ViewControllerOption {
        // swiftlint:disable force_cast
        return UIStoryboard(name: "Main",
                            bundle: nil)
            .instantiateViewController(withIdentifier: "Option") as! ViewControllerOption
    }
    
    let dataSource = DataSourceEquipos()
    
    lazy var viewModel : ViewModelEquiposPoke = {
        let viewModel = ViewModelEquiposPoke(dataSource: dataSource)
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Referencia Database
        dbRef = Database.database().reference().child("User").child(Globales.idUser)
        
        editTeam.visibility = .invisible
        btnRenombrar.visibility = .invisible
    }
    
    @IBAction func btnShared(_ sender: Any) {
        print("Shared")
        let items = [URL(string: "https://www.apple.com")!]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }
    
    @IBAction func btnEditName(_ sender: Any) {
        print("EditName")
        editTeam.visibility = .visible
        btnRenombrar.visibility = .visible
        textOption.visibility = .invisible
        
    }
    @IBAction func btnEditTeam(_ sender: Any) {
        print("EditTeam")
       //Limpiar array
        Globales.arrData = []
        Globales.arrSelectedIndex = []
        Globales.arrSelectedData = []
        Globales.equipoPokemon = []
        
        for lista in mEquipoModel[0].listPokemon{
            let strData = lista.nombre.capitalized
            let position = Int(lista.id)
            let indexPath = IndexPath(row: position!, section: 0)
            
            Globales.arrSelectedIndex.append(indexPath)
            Globales.arrSelectedData.append(strData)
        }
        Globales.equipoPokemon = mEquipoModel[0].listPokemon
        
        sheetControllerOption.closeSheet()
        NotificationCenter.default.post(name: .didUpdate, object: mEquipoModel[0])
    }
    @IBAction func btnDelete(_ sender: Any) {
        print("Delete")
        DeleteData(mEquipoModel[0].idEquipo)
        sheetControllerOption.closeSheet()
    }
    
    @IBAction func btnRenombrar(_ sender: Any) {
        if !editTeam.text!.isEmpty{
            EditarBase(mEquipoModel[0].idEquipo, editTeam.text!)
            sheetControllerOption.closeSheet()
        }else{
            JNBBottombar.shared.show(text: "Escribe un nuevo nombre.")
            editTeam.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 3, revert: true)
        }
    }
    
    func EditarBase(_ id: String,_ nombre: String){
        //Editar nombre
        dbRef.child("team").child(id).child("nombre").setValue(nombre)
        UpdateData()
    }
    
    func DeleteData(_ id: String){
        //Borrar equipo
        dbRef.child("team").child(id).removeValue()
        UpdateData()
    }
    
    func UpdateData(){
        //lista Equipos
        self.listaPoke.delegate = self.dataSource
        
        // Do any additional setup after loading the view.
        self.listaPoke.dataSource = self.dataSource
        self.dataSource.data.addAndNotify(observer: self) { [weak self] in
            self?.listaPoke.reloadData()
        }
        //consulta equipos
        self.viewModel.getEquipos()
    }
}
