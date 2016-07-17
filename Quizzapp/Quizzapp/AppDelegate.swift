//
//  AppDelegate.swift
//  Quizzapp
//
//  Created by Ethan Hess on 1/17/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

import UIKit

let screenWidth = UIScreen.mainScreen().bounds.size.width
let screenHeight = UIScreen.mainScreen().bounds.size.height

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        if !(NSUserDefaults.standardUserDefaults().boolForKey(soundKey)) {
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: soundKey)
        }
        
        print(screenWidth)
        print(screenHeight)
        
        let viewController = ViewController()
        
        let navigationController = UINavigationController(rootViewController: viewController)
        
        self.window?.backgroundColor = UIColor.whiteColor()
        self.window?.rootViewController = navigationController
        
        setUpAppearance()
        
        return true
    }
    
    func setUpAppearance() {
        
//        window?.tintColor = Colors().navBackgroundColor
        
//        UINavigationBar.appearance().barTintColor = Colors().navBackgroundColor
//        UINavigationBar.appearance().tintColor = Colors().navTextColor
//
//        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: UIFont(name: cFont, size: 20)!, NSForegroundColorAttributeName: Colors().navTextColor]
//        
//        UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName: UIFont(name: cFont, size: 16)!, NSForegroundColorAttributeName: Colors().navTextColor], forState: .Normal)
        
        if (scheme() != nil) {
            
            if scheme() == space {
                
                self.setNavBarAppearance(Colors().navBackgroundColor, textColor: UIColor.whiteColor(), fontName: cFont)
                
            } else if scheme() == nature {
                
                self.setNavBarAppearance(UIColor.brownColor(), textColor: UIColor.whiteColor(), fontName: cFont)
            }
        }
        
        else {
        
        self.setNavBarAppearance(Colors().navBackgroundColor, textColor: UIColor.whiteColor(), fontName: cFont)
            
        }
    }
    
    //make global function
    
    func scheme() -> String? {
        
        return NSUserDefaults.standardUserDefaults().objectForKey(schemeKey) as? String
    }
    
    
    func setNavBarAppearance(backgroundColor: UIColor, textColor: UIColor, fontName: String) {
        
        UINavigationBar.appearance().barTintColor = backgroundColor
        UINavigationBar.appearance().tintColor = textColor
        
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: UIFont(name: fontName, size: 20)!, NSForegroundColorAttributeName: textColor]
        
        UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName: UIFont(name: fontName, size: 16)!, NSForegroundColorAttributeName: textColor], forState: .Normal)
    }
    

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

