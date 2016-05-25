//
//  Colors.swift
//  Quizzapp
//
//  Created by Ethan Hess on 2/8/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

import Foundation
import UIKit

let cFont = "Courier"

class Colors {
    
    var viewBackgroundColor : UIColor {
        get {
            return RGB(213, 239, 239)
        }
    }
    
    var navBackgroundColor : UIColor {
        get {
            return RGB(8, 7, 56)
        }
    }
    
    var navTextColor : UIColor {
        get {
            return RGB(255, 204, 0)
        }
    }
    
    var detailViewBackgroundColor : UIColor {
        get {
            return RGB(0, 168, 219)
        }
    }
    
    var cardBackgroundColor : UIColor {
        get {
            return RGB(229, 224, 199)
        }
    }
    
    var cardTextColor : UIColor {
        get {
            return RGB(228, 232, 0)
        }
    }
    
    var cardLabelBackgroundColor : UIColor {
        get {
            return RGB(0, 6, 48)
        }
    }
    
    var qLineColor : UIColor {
        get {
            return RGB(91, 234, 30)
        }
    }
    
    var cardLineColor : UIColor {
        get {
            return RGB(227, 252, 0)
        }
    }
    
    var wrongLabelColor : UIColor {
        get {
            return UIColor(red: 249/255, green: 246/255, blue: 34/255, alpha: 1.0)
        }
    }
    
    var rightLabelColor : UIColor {
        get {
            return UIColor(red: 48/255, green: 247/255, blue: 34/255, alpha: 1.0)
        }
    }
    
    private func RGB(r: CGFloat, _ g: CGFloat, _ b: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
}