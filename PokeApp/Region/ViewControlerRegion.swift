//
//  ViewControlerRegion.swift
//  PokeApp
//
//  Created by Josael Hernandez on 9/6/19.
//  Copyright © 2019 Josael Hernandez. All rights reserved.
//

import Foundation
import UIKit
import GoogleSignIn
import FirebaseAuth


class ViewControllerRegion: UIViewController,UITabBarDelegate{
    
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var listTable: UITableView!
    
    let dataSource = TableDataSource()
    
    lazy var viewModel : ViewModelRegion = {
        let viewModel = ViewModelRegion(dataSource: dataSource)
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        
        //showToast(message: "\(appDelegate.email)")
        //lista region
        self.listTable.delegate = self.dataSource
        //Menu bottom
        self.tabBar.delegate = self
        self.tabBar.selectedItem = self.tabBar.items![0]
        
        //for second tab
        //(self.tabBar.items![1]).badgeValue = " "
        
        // Do any additional setup after loading the view.
        self.listTable.dataSource = self.dataSource
        self.dataSource.data.addAndNotify(observer: self) { [weak self] in
            self?.listTable.reloadData()
        }
        //consulta regiones
        self.viewModel.getRegion()
        
        //observer
        NotificationCenter.default.addObserver(self, selector: #selector(onllamarViewController(_:)), name: .llamarViewController, object: nil)
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        //select item bottom bar
        if(item.tag == 0) {
            // first tab bar code
            showToast(message: "1")
        }
        else if(item.tag == 1) {
            // second tab bar code
            showToast(message: "2")
            starViewController("Equipos")
            //self.navigationController?.popToViewController(ofClass: ViewControllerEquiposPokemon.self)
            
        }else if(item.tag == 2) {
            // second tab bar code
            //showToast(message: "3")
            if GIDSignIn.sharedInstance()?.currentUser != nil{
                GIDSignIn.sharedInstance()?.signOut()
            }else{
                let firebaseAuth = Auth.auth()
                do {
                    try firebaseAuth.signOut()
                } catch let signOutError as NSError {
                    print ("Error signing out: \(signOutError)")
                }
            }
            
            
            
            //starViewController("Login")
            navigationController?.popToViewController(ofClass: ViewControllerLoginSocial.self)
        }
    }
    
    @objc func onllamarViewController(_ notification:Notification) {
        if let data = notification.object as? Result
        {
            //pasar datos entre viewcontroller
            let selectionPoke = ViewControllerSelectionPoke.instantiate()
            selectionPoke.urlpokedex = data.url
            selectionPoke.nombreRegion = data.name
            self.navigationController?.pushViewController(selectionPoke, animated: true)
        }
        
        NotificationCenter.default.removeObserver(onllamarViewController)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBar.selectedItem = self.tabBar.items![0]
    }
    
}
