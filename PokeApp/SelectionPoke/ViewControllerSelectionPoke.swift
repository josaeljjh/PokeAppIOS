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


class ViewControllerSelectionPoke: UIViewController,UICollectionViewDelegate{
    
    var pipeline = ImagePipeline.shared
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    
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
        
        //lista region
        self.GridCollection.delegate = self
        
        // Do any additional setup after loading the view.
        self.GridCollection.dataSource = self.dataSource
        self.dataSource.data.addAndNotify(observer: self) { [weak self] in
            self?.GridCollection.reloadData()
        }
        
        //consulta regiones
        self.viewModel.getPokedex()
        
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveData(_:)), name: .didReceiveData, object: nil)
        
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
        
    }
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func onDidReceiveData(_ notification:Notification) {
        showToast(message: "error mierda por fin")
    }
}

extension Notification.Name {
    static let didReceiveData = Notification.Name("didReceiveData")
    static let didCompleteTask = Notification.Name("didCompleteTask")
    static let completedLengthyDownload = Notification.Name("completedLengthyDownload")
}
