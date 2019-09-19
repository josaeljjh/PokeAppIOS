//
//  UIViewController.swift
//  PokeApp
//
//  Created by Josael Hernandez on 9/18/19.
//  Copyright © 2019 Josael Hernandez. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    /// The sheet view controller presenting the current view controller heiarchy (if any)
    public var sheetViewController: SheetViewController? {
        var parent = self.parent
        while let currentParent = parent {
            if let sheetViewController = currentParent as? SheetViewController {
                return sheetViewController
            } else {
                parent = currentParent.parent
            }
        }
        return nil
    }
}
