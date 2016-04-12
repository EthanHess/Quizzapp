//
//  ViewController.swift
//  Quizzapp
//
//  Created by Ethan Hess on 1/17/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var labelImageView = UIImageView()
    var qLabel = UILabel() //maybe change to custom image eventually
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: #selector(ViewController.pushToDetailView))
        self.navigationItem.rightBarButtonItem = barButtonItem
        
        let onboardBarButtonItem = UIBarButtonItem(title: "Instructions", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(ViewController.presentOnboarding))
        self.navigationItem.leftBarButtonItem = onboardBarButtonItem
        
        self.view.backgroundColor = Colors().viewBackgroundColor
        
        qLabel = UILabel(frame: CGRectMake(self.view.frame.size.width / 2 - 5, 150, 10, 10))
        qLabel.text = "Q"
        qLabel.textAlignment = NSTextAlignment.Center
        qLabel.textColor = UIColor.whiteColor()
        qLabel.font = UIFont(name: "ArialHebrew", size: 244)
        self.view.addSubview(qLabel)
        
        self.labelImageView = UIImageView(frame: CGRectMake(50, 380, self.view.frame.size.width - 100, 50))
        self.labelImageView.image = UIImage(named: "uizzap")
        self.labelImageView.alpha = 0
        self.view.addSubview(self.labelImageView)
        
        loadAnimation()
    }
    
    func loadAnimation() {
        
        UIView.animateWithDuration(1, animations: {
            
            let newLabelFrame = CGRectMake(50, 100, self.view.frame.size.width - 100, 275)
            
            self.qLabel.frame = newLabelFrame
        
            
            }) { (success) in
                
            self.fadeInLabel()
        }
     }
    
    func fadeInLabel() {
        
        UIView.animateWithDuration(1, animations: { () -> Void in
            
            self.labelImageView.alpha = 1
            
            }) { (completed) -> Void in
                
            self.moveViewsSideBySide()
                
        }
    }
    
    func moveViewsSideBySide() {
        
        UIView.animateWithDuration(1, animations: { 
            
            
            }) { (success) in
                
                
        }
    }
    
    func pushToDetailView() {
        
        let subjectView = SubjectListViewController()
        
        self.navigationController?.pushViewController(subjectView, animated: true)
        
    }
    
    func presentOnboarding() {
        
        //present PageViewController here
        
        let pageViewController = PageViewController()
        
        self.navigationController?.pushViewController(pageViewController, animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

