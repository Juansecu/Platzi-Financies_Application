//
//  Shadow.swift
//  Financies
//
//  Created by Juan on 12/17/19.
//  Copyright © 2019 Juan. All rights reserved.
//

import UIKit

extension UIView {
    var borderUIColor: UIColor {
        get {
            guard let color = layer.borderColor else {
                return UIColor.black
            }
            
            return UIColor(cgColor: color)
        }
        
        set {
            layer.borderColor = newValue.cgColor
        }
    }
}
