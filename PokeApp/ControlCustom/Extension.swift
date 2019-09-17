//
//  Extension.swift
//  PokeApp
//
//  Created by Josael Hernandez on 9/11/19.
//  Copyright © 2019 Josael Hernandez. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showToast(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height:35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = UIFont(name: Fonts.avenirNextCondensedDemiBold, size: 18)
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    struct Fonts {
        static let avenirNextCondensedDemiBold = "AvenirNextCondensed-DemiBold"
    }
    
    func ShowSheet(_ titulo : String ,_ mensaje : String) {
        let alertController = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.left
        
        let attributedTitle = NSAttributedString(string: titulo, attributes: [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16.5, weight: UIFont.Weight.bold), //your font here
            NSAttributedString.Key.foregroundColor : UIColor.black])
        alertController.setValue(attributedTitle, forKey: "attributedTitle")
        
        let attributedMessage = NSAttributedString(string: mensaje, attributes: [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14.5, weight: UIFont.Weight.light), //your font here
            NSAttributedString.Key.foregroundColor : UIColor.gray
            ])
        alertController.setValue(attributedMessage, forKey: "attributedMessage")
        
        let OKAction = UIAlertAction(title: "Cerrar", style: .default) { (action) in
            // ...
        }
        alertController.addAction(OKAction)
        
        //let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        // ...
        //}
        //alertController.addAction(cancelAction)
        
        //let destroyAction = UIAlertAction(title: "Destroy", style: .destructive) { (action) in
            //println(action)
        //}
        //alertController.addAction(destroyAction)
        
        self.present(alertController, animated: true) {
            // ...
        }
    }
}

