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
        
        return NSUserDefaults.standardUserDefaults().objectForKey(schemeKey) as? String
    }
    
    func setNavBarAppearanceForVC(viewController: UIViewController, backgroundColor: UIColor, textColor: UIColor) {
        
        viewController.navigationController?.navigationBar.barTintColor = backgroundColor
        viewController.navigationController?.navigationBar.tintColor = textColor
        
        viewController.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: cFont, size: 20)!, NSForegroundColorAttributeName: textColor]
        
        viewController.navigationController?.navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: UIFont(name: cFont, size: 16)!, NSForegroundColorAttributeName: textColor], forState: .Normal)
        viewController.navigationController?.navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: UIFont(name: cFont, size: 16)!, NSForegroundColorAttributeName: textColor], forState: .Normal)
    }
    
}