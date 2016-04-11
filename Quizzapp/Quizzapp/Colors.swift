//
//  Colors.swift
//  Quizzapp
//
//  Created by Ethan Hess on 2/8/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

import Foundation
import UIKit

class Colors {
    
    var cardColorOne : UIColor {
        get {
            return UIColor(red: (35)/255, green: (200)/255, blue: (55)/255, alpha: 1)
        }
    }
    
    var cardColorTwo : UIColor {
        get {
            return UIColor(red: (65)/255, green: (140)/255, blue: (160)/255, alpha: 1)
        }
    }
    
    var cardColorThree : UIColor {
        get {
            return UIColor(red: (95)/255, green: (170)/255, blue: (130)/255, alpha: 1)
        }
    }
    
    //Make more custom colors with RGB values online
    
    var viewBackgroundColor : UIColor {
        get {
            return UIColor(red: 205/255, green: 252/255, blue: 201/255, alpha: 1.0)
        }
    }
    
    var cardBackgroundColor : UIColor {
        get {
            return UIColor(red: 74/255, green: 69/255, blue: 211/255, alpha: 1.0)
        }
    }
    
    var cardTextColor : UIColor {
        get {
            return UIColor(red: 242/255, green: 244/255, blue: 217/255, alpha: 1.0)
        }
    }
    
}