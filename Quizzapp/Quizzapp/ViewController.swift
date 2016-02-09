//
//  ViewController.swift
//  Quizzapp
//
//  Created by Ethan Hess on 1/17/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var onboardButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadAnimation()
        
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "pushToDetailView")
        self.navigationItem.rightBarButtonItem = barButtonItem
        
        //establish colors
        
        let colorOne = CGFloat(55)
        let colorTwo = CGFloat(140)
        let colorThree = CGFloat(245)
        
        self.view.backgroundColor = UIColor(red: colorOne / 255.0, green: colorTwo / 255.0, blue: colorThree / 255.0, alpha: 1.0)
        
        onboardButton = UIButton(frame: CGRectMake(20, self.view.frame.size.height / 2 - 50, self.view.frame.size.width - 40, 100))
        onboardButton.setTitle("Instructions", forState: UIControlState.Normal)
        onboardButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        onboardButton.setTitleShadowColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
        onboardButton.addTarget(self, action: "presentOnboarding", forControlEvents: UIControlEvents.TouchUpInside)
        onboardButton.titleLabel?.font = UIFont(name: "Chalkduster", size: 42)
        self.view.addSubview(onboardButton)
    }
    
    func loadAnimation() {
        
        //load animation here
    }
    
    func pushToDetailView() {
        
        let subjectView = SubjectListViewController()
        
        self.navigationController?.pushViewController(subjectView, animated: true)
    }
    
    func presentOnboarding() {
        
        //presentPageViewController here
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

