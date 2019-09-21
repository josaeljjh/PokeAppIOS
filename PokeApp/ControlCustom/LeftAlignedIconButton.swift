//
//  LeftAlignedIconButton.swift
//  PokeApp
//
//  Created by Josael Hernandez on 9/6/19.
//  Copyright © 2019 Josael Hernandez. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class LeftAlignedIconButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = false
        }
    }
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
            layer.masksToBounds = false
        }
    }
    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
            layer.shadowColor = UIColor.darkGray.cgColor
        }
    }
    @IBInspectable var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
            layer.shadowColor = UIColor.black.cgColor
            layer.masksToBounds = false
        }
    }
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        let titleRect = super.titleRect(forContentRect: contentRect)
        let imageSize = currentImage?.size ?? .zero
        let availableWidth = contentRect.width - imageEdgeInsets.right - imageSize.width - titleRect.width
        return titleRect.offsetBy(dx: round(availableWidth / 2), dy: 0)
    }
}
