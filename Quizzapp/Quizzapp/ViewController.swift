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
    
    var qBackground = QBackground()
    var labelImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "pushToDetailView")
        self.navigationItem.rightBarButtonItem = barButtonItem
        
        //establish colors
        
//        let colorOne = CGFloat(55)
//        let colorTwo = CGFloat(140)
//        let colorThree = CGFloat(245)
        
        self.view.backgroundColor = Colors().viewBackgroundColor
        
        onboardButton = UIButton(frame: CGRectMake(20, self.view.frame.size.height / 2 - 50, self.view.frame.size.width - 40, 100))
        onboardButton.setTitle("Instructions", forState: UIControlState.Normal)
        onboardButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        onboardButton.setTitleShadowColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
        onboardButton.addTarget(self, action: "presentOnboarding", forControlEvents: UIControlEvents.TouchUpInside)
        onboardButton.titleLabel?.font = UIFont(name: "Chalkduster", size: 42)
        self.view.addSubview(onboardButton)
        
        //set up imageviews for load animation
        
        let dimension = self.view.frame.size.width / 4
        
        self.qBackground = QBackground(frame: CGRectMake(75, 125, 0, 0))
        self.qBackground.layer.cornerRadius = 37.5
        self.qBackground.layer.masksToBounds = true
//        self.view.sendSubviewToBack(self.qBackground)
        self.view.addSubview(self.qBackground)
        
        
        self.labelImageView = UIImageView(frame: CGRectMake(150, 120, self.view.frame.size.width / 2, 50))
        self.labelImageView.image = UIImage(named: "uizzap")
        self.labelImageView.alpha = 0
        self.view.addSubview(self.labelImageView)
        
        loadAnimation()
    }
    
    func loadAnimation() {
        
        //load animation here
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            
            self.qBackground.frame = CGRectMake(50, 100, 75, 75)
            
            }) { (completed) -> Void in
                
//                self.qBackground.image = UIImage(named: "")
//                self.qBackground.hidden = false
                self.qBackground.animateBackroundRect()
                
                self.performSelector("fadeInLabel", withObject: self, afterDelay: 1)
        }
    }
    
    func fadeInLabel() {
        
        UIView.animateWithDuration(1, animations: { () -> Void in
            
            self.labelImageView.alpha = 1
            
            }) { (completed) -> Void in
                
                
        }
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

