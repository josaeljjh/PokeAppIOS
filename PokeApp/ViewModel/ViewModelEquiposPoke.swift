//
//  ViewModelEquiposPoke.swift
//  PokeApp
//
//  Created by Josael Hernandez on 9/27/19.
//  Copyright © 2019 Josael Hernandez. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase
import Alamofire

class ViewModelEquiposPoke{
    
    // we have to initialize the Dynamic var with the
    // data type we want
    weak var dataSource : GenericDataSource<EquipoModel>?
    //instancia de clase
    var equipos = [EquipoModel]()
    init(dataSource : GenericDataSource<EquipoModel>?) {
        self.dataSource = dataSource
    }
    
    func getEquipos() {
        let ref = Database.database().reference(withPath: "Equipos")
        ref.observeSingleEvent(of: .value, with: { equipos in
            
            if equipos.exists() {
                for child in equipos.children {
                    if let childSnapshot = child as? DataSnapshot,
                        let datos = childSnapshot.value as? [String:Any]
                    {
                        do {
                            let jsonData = try JSONSerialization.data(withJSONObject: datos, options: [])
                            let data = try JSONDecoder().decode(EquipoModel.self, from: jsonData)
                            //print (data)
                            self.equipos.append(data)
                            self.dataSource?.data.value = self.equipos
                            
                            NotificationCenter.default.post(name: .HideLoadig, object: nil)
                        } catch let error {
                            print("error firebase: ",error)
                        }
                    }
                }
            }else{
                let mensaje = [ "msj" : "No tienes equipos pokemon" ]
                NotificationCenter.default.post(name: .didReceiveError, object: nil, userInfo: mensaje)
            }
        }){ (error) in
            let mensaje = [ "msj" : "No tienes equipos pokemon" ]
            NotificationCenter.default.post(name: .didReceiveError, object: nil, userInfo: mensaje)
        }
        
    }
}
