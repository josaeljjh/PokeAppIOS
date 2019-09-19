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


class ViewControllerSelectionPoke: UIViewController{
    
    var pipeline = ImagePipeline.shared
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    var spinner:JHSpinnerView!
    @IBOutlet weak var Titulo: UILabel!
    @IBOutlet weak var GridCollection: UICollectionView!
    
    var urlpokedex : String!
    var nombreRegion : String!
    let dataSource = CollectionDataSource()
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
        
        // Loading
        spinner = JHSpinnerView.showOnView(view, spinnerColor:#colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1), overlay:.custom(CGSize(width: 150, height: 130), 20), overlayColor:UIColor.black.withAlphaComponent(0.6), fullCycleTime:4.0, text:"Loading")
        
        view.addSubview(spinner)
        
        Titulo.text = "Región "+nombreRegion.capitalized
        //capturar tamaño de pantalla
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        // Do any additional setup after loading the view, typically from a nib.
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 1, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: screenWidth/3, height: screenWidth/3)
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
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
        
    }
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func onDidReceiveError(_ notification:Notification) {
        //showToast(message: "Esta región no contiene pokémon")
        JNBBottombar.shared.show(text: "Esta región no contiene pokémon.")
        // Hide Loading
        spinner.dismiss()
    }
    @objc func onHideLoadig(_ notification:Notification) {
        // Hide Loading
        spinner.dismiss()
    }
    @objc func onDidReceiveData(_ notification:Notification) {
        if let data = notification.object as? PokemonEntry
        {
            SheetDetalle(data)
        }
    }
    
    func SheetDetalle(_ datos:PokemonEntry) {
        let controller = ViewControllerDetalle.instantiate()
        var sheetController = SheetViewController()
        sheetController = SheetViewController(controller: controller, sizes: [ .halfScreen])
        // Adjust how the bottom safe area is handled on iPhone X screens
        sheetController.blurBottomSafeArea = false
        sheetController.adjustForBottomSafeArea = true
        // Turn off rounded corners
        sheetController.topCornersRadius = 0
        // Make corners more round
        sheetController.topCornersRadius = 15
        // Disable the dismiss on background tap functionality
        sheetController.dismissOnBackgroundTap = false
        // Extend the background behind the pull bar instead of having it transparent
        sheetController.extendBackgroundBehindHandle = true
        // Change the overlay color
        //sheetController.overlayColor = UIColor.red
        // Change the handle color
        sheetController.handleColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        controller.sheetControllerDetalle = sheetController
        controller.datos = [datos]
        self.present(sheetController, animated: true, completion: nil)
    }
}
