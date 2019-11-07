//
//  AppFunctions.swift
//  Quizzapp
//
//  Created by Ethan Hess on 7/13/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

import Foundation
import UIKit

class AppFunctions {
    
    func scheme() -> String? {
        return UserDefaults.standard.object(forKey: schemeKey) as? String
    }
    
    func setNavBarAppearanceForVC(_ viewController: UIViewController, backgroundColor: UIColor, textColor: UIColor) {
        
        viewController.navigationController?.navigationBar.barTintColor = backgroundColor
        viewController.navigationController?.navigationBar.tintColor = textColor
        
        viewController.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: cFont, size: 20)!, NSAttributedStringKey.foregroundColor: textColor]
        
        viewController.navigationController?.navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: cFont, size: 16)!, NSAttributedStringKey.foregroundColor: textColor], for: UIControlState())
        viewController.navigationController?.navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: cFont, size: 16)!, NSAttributedStringKey.foregroundColor: textColor], for: UIControlState())
    }
    
}
