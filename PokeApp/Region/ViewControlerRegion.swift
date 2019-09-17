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


class ViewControllerRegion: UIViewController,UITabBarDelegate,UITableViewDelegate{
    
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var listTable: UITableView!
    
    static let shared = ViewControllerRegion()
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
        
        // Do any additional setup after loading the view.
        self.listTable.dataSource = self.dataSource
        self.dataSource.data.addAndNotify(observer: self) { [weak self] in
            self?.listTable.reloadData()
        }
        //consulta regiones
        self.viewModel.getRegion()
        
        NotificationCenter.default.addObserver(self, selector: #selector(onllamarViewController(_:)), name: .didReceiveData, object: nil)
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
        }else if(item.tag == 2) {
            // second tab bar code
            showToast(message: "3")
            GIDSignIn.sharedInstance()?.signOut()
            let nextViewController = UIStoryboard(name: "Main",bundle: nil).instantiateViewController(withIdentifier: "Login") as! ViewControllerLoginSocial
            self.navigationController?.pushViewController(nextViewController, animated:true)
        }
    }
    
    @objc func onllamarViewController(_ notification:Notification) {
        if let data = notification.object as? Result
        {
            //print("\(data.name) scored \(data.url) points!")
            let selectionPoke = ViewControllerSelectionPoke.instantiate()
            selectionPoke.urlpokedex = data.url
            selectionPoke.nombreRegion = data.name
            self.navigationController?.pushViewController(selectionPoke, animated: true)
        }
    }
}
extension Notification.Name {
    static let llamarViewController = Notification.Name("llamarViewController")
}