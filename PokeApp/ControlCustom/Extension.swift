//
//  Extension.swift
//  PokeApp
//
//  Created by Josael Hernandez on 9/11/19.
//  Copyright © 2019 Josael Hernandez. All rights reserved.
//

import Foundation
import UIKit
import MaterialShowcase
import FittedSheets
import Nuke

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
    
    func SheetDetalle(_ datos:PokemonDetalle,_ indexPath:Int,_ GridCollection:UICollectionView,_ nombreRegion:String) {
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
        controller.GridCollection = GridCollection
        controller.position = indexPath
        controller.textRegion = nombreRegion
        self.present(sheetController, animated: true, completion: nil)
    }
    
    
    func ShowHelp(_ vista:UIView,_ titulo:String,_ descripcion:String,_ radio:CGFloat) {
          let showcase = MaterialShowcase()
          // Target
          showcase.targetTintColor = UIColor.blue
          showcase.targetHolderRadius = radio
          showcase.targetHolderColor = UIColor.clear
          showcase.setTargetView(view: vista) // always required to set targetView
          showcase.primaryText = titulo
          showcase.secondaryText = descripcion
          // Background
          showcase.backgroundPromptColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
          showcase.backgroundPromptColorAlpha = 0.96
          showcase.backgroundViewType = .circle // default is .circle
          
          // Text
          showcase.primaryTextColor = UIColor.white
          showcase.secondaryTextColor = UIColor.white
          showcase.primaryTextFont = UIFont.boldSystemFont(ofSize: 20)
          showcase.secondaryTextFont = UIFont.systemFont(ofSize: 15)
          //Alignment
          showcase.primaryTextAlignment = .left
          showcase.secondaryTextAlignment = .left
          // Animation
          showcase.aniComeInDuration = 0.5 // unit: second
          showcase.aniGoOutDuration = 0.5 // unit: second
          showcase.aniRippleScale = 1.5
          showcase.aniRippleColor = UIColor.white
          showcase.aniRippleAlpha = 0.2
          showcase.show(completion: {
              // You can save showcase state here
              // Later you can check and do not show it again
          })
      }
    
    func loadImage(_ urlimg: URL?,_ image: UIImageView) {
          let pipeline = ImagePipeline.shared
          let screenWidth = UIScreen.main.bounds.size.width / 3
          let targetSize = CGSize(width: screenWidth, height: (screenWidth * 2 / 3))
          
          let request = ImageRequest(
              url: urlimg!,
              processors: [
                  ImageProcessor.Resize(size: targetSize),
                  ImageProcessor.Circle()
              ]
          )
          
          var options = ImageLoadingOptions(transition: .fadeIn(duration: 0.5))
          options.pipeline = pipeline
          
          Nuke.loadImage(with: request, options: options, into:image)
      }
}

extension UIView {
    
    enum Visibility {
        case visible
        case invisible
        case gone
    }
    
    var visibility: Visibility {
        get {
            let constraint = (self.constraints.filter{$0.firstAttribute == .height && $0.constant == 0}.first)
            if let constraint = constraint, constraint.isActive {
                return .gone
            } else {
                return self.isHidden ? .invisible : .visible
            }
        }
        set {
            if self.visibility != newValue {
                self.setVisibility(newValue)
            }
        }
    }
    
    private func setVisibility(_ visibility: Visibility) {
        let constraint = (self.constraints.filter{$0.firstAttribute == .height && $0.constant == 0}.first)
        
        switch visibility {
        case .visible:
            constraint?.isActive = false
            self.isHidden = false
            break
        case .invisible:
            constraint?.isActive = false
            self.isHidden = true
            break
        case .gone:
            if let constraint = constraint {
                constraint.isActive = true
            } else {
                let constraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 0)
                self.addConstraint(constraint)
                constraint.isActive = true
            }
        }
    }
}

extension Sequence {
    public func toDictionary<Key: Hashable>(with selectKey: (Iterator.Element) -> Key) -> [Key:Iterator.Element] {
        var dict: [Key:Iterator.Element] = [:]
        for element in self {
            dict[selectKey(element)] = element
        }
        return dict
    }
}

extension Notification.Name {
    //declarar nombre de notificacion
    static let llamarViewController = Notification.Name("llamarViewController")
    static let didReceiveError = Notification.Name("didReceiveError")
    static let didReceiveData = Notification.Name("didReceiveData")
    static let HideLoadig = Notification.Name("HideLoadig")
    static let didBtnSave = Notification.Name("didBtnSave")
    static let didReceiveDetalle = Notification.Name("didReceiveDetalle")
}
