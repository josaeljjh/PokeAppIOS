//
//  CurrencyDataSource.swift
//  PokeApp
//
//  Created by Josael Hernandez on 9/12/19.
//  Copyright © 2019 Josael Hernandez. All rights reserved.
//

import Foundation
import UIKit
import GoogleSignIn

class TableDataSource : GenericDataSource<Result>, UITableViewDataSource,UITableViewDelegate  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "tableItem", for: indexPath) as! TableViewCell
        
        //set data list
        tableCell.txtRegion.text = data.value[indexPath.item].name.capitalized
        return tableCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(data.value[indexPath.item].name.capitalized)
        let datos = data.value[indexPath.item]
        NotificationCenter.default.post(name: .didReceiveData, object: datos)
    }
    
}