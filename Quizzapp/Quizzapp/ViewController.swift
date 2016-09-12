//
//  ViewController.swift
//  Quizzapp
//
//  Created by Ethan Hess on 1/17/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //qlabel animations
    
    var qTainerView = QContainerView()
    
    //uizzap labels
    
    var uLabel = UILabel()
    var iLabel = UILabel()
    var z1Label = UILabel()
    var z2Label = UILabel()
    var aLabel = UILabel()
    var pLabel = UILabel()
    
    var labelColor = UIColor()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: #selector(ViewController.pushToDetailView))
        self.navigationItem.rightBarButtonItem = barButtonItem
        
        let onboardBarButtonItem = UIBarButtonItem(title: "Settings", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(ViewController.presentOnboarding))
        self.navigationItem.leftBarButtonItem = onboardBarButtonItem
        
        if (scheme() != nil) {
            
            if scheme() == space {
                
                defaultImageView()
                
            } else if scheme() == nature {
                
                let imageView = UIImageView(frame: view.bounds)
                imageView.image = UIImage(named: "NatureBackground")
                view.addSubview(imageView)
                
            } else {
                defaultImageView()
            }
            
        } else {
            defaultImageView()
        }
        
    }
    
    func defaultImageView() {
        
        let imageView = UIImageView(frame: view.bounds)
        imageView.image = UIImage(named: "mainQBackground")
        view.addSubview(imageView)
    }
    
    func scheme() -> String? {
        
        return NSUserDefaults.standardUserDefaults().objectForKey(schemeKey) as? String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bigBangSound()
    }
    
    func bigBangSound() {
        
        let url = NSBundle.mainBundle().URLForResource("grandOpening", withExtension: "wav")
        
        SoundController.sharedManager.playAudioFileAtURL(url!)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        addContainerView()
        
        //maybe do after first animation
        setUpOtherLetters()
    }
    
    func addContainerView() {
        
        let containerWidth : CGFloat = 250
        
        qTainerView.frame = CGRect(x: view.bounds.width / 2 - containerWidth / 2, y: 100, width: containerWidth, height: containerWidth)
        
        qTainerView.parentFrame = view.frame
        
        qTainerView.expandCircle()
        
        self.expandSpaceInQ()
        
        view.addSubview(qTainerView)
    }
    
    func expandSpaceInQ() {
        
        qTainerView.expandSmallerCircle()
    }

    func pushToDetailView() {
        
        let subjectView = SubjectListViewController()
        
        self.navigationController?.pushViewController(subjectView, animated: true)
        
    }
    
    func presentOnboarding() {
        
        let creditsViewController = CreditsViewController()
        
        self.navigationController?.pushViewController(creditsViewController, animated: true)
        
    }

    func setUpOtherLetters() {
        
        if (scheme() != nil) {
            
            if scheme() == space {
                
                labelColor = Colors().qLineColor
                
            } else if scheme() == nature {
                
                labelColor = UIColor.blackColor()
                
            } else {
                
                labelColor = Colors().qLineColor
            }
        } else {
            labelColor = Colors().qLineColor
        }
        
        let labelDimension : CGFloat = self.view.frame.size.width / 6
        
        uLabel.frame = CGRect(x: -labelDimension * 3, y: view.bounds.height - 150, width: labelDimension, height: labelDimension)
        uLabel.alpha = 0
        uLabel.text = "U"
        uLabel.textAlignment = NSTextAlignment.Center
        uLabel.font = UIFont(name: "Arial-Hebrew", size: 84)
        uLabel.sizeToFit()
        uLabel.textColor = labelColor
        uLabel.backgroundColor = UIColor.clearColor()
        
        iLabel.frame = CGRect(x: -labelDimension * 2, y: view.bounds.height - 150, width: labelDimension, height: labelDimension)
        iLabel.alpha = 0
        iLabel.text = "I"
        iLabel.textAlignment = NSTextAlignment.Center
        iLabel.font = UIFont(name: "Arial-Hebrew", size: 84)
        iLabel.sizeToFit()
        iLabel.textColor = labelColor
        iLabel.backgroundColor = UIColor.clearColor()
        
        z1Label.frame = CGRect(x: -labelDimension, y: view.bounds.height - 150, width: labelDimension, height: labelDimension)
        z1Label.alpha = 0
        z1Label.text = "Z"
        z1Label.textAlignment = NSTextAlignment.Center
        z1Label.font = UIFont(name: "Arial-Hebrew", size: 84)
        z1Label.sizeToFit()
        z1Label.textColor = labelColor
        z1Label.backgroundColor = UIColor.clearColor()
        
        z2Label.frame = CGRect(x: view.bounds.width + labelDimension * 2, y: view.bounds.height - 150, width: labelDimension, height: labelDimension)
        z2Label.alpha = 0
        z2Label.text = "Z"
        z2Label.textAlignment = NSTextAlignment.Center
        z2Label.font = UIFont(name: "Arial-Hebrew", size: 84)
        z2Label.sizeToFit()
        z2Label.textColor = labelColor
        z2Label.backgroundColor = UIColor.clearColor()
        
        aLabel.frame = CGRect(x: view.bounds.width + labelDimension, y: view.bounds.height - 150, width: labelDimension, height: labelDimension)
        aLabel.alpha = 0
        aLabel.text = "A"
        aLabel.textAlignment = NSTextAlignment.Center
        aLabel.font = UIFont(name: "Arial-Hebrew", size: 84)
        aLabel.sizeToFit()
        aLabel.textColor = labelColor
        aLabel.backgroundColor = UIColor.clearColor()
        
        pLabel.frame = CGRect(x: view.bounds.width, y: view.bounds.height - 150, width: labelDimension, height: labelDimension)
        pLabel.alpha = 0
        pLabel.text = "P"
        pLabel.textAlignment = NSTextAlignment.Center
        pLabel.font = UIFont(name: "Arial-Hebrew", size: 84)
        pLabel.sizeToFit()
        pLabel.textColor = labelColor
        pLabel.backgroundColor = UIColor.clearColor()
        
        view.addSubview(uLabel)
        view.addSubview(iLabel)
        view.addSubview(z1Label)
        view.addSubview(z2Label)
        view.addSubview(aLabel)
        view.addSubview(pLabel)
        
        animateLabels()
        
    }
    
    func animateLabels() {
        
        let yCoord = view.bounds.height - 150
        let labelDimension = self.view.frame.size.width / 6
        
        UIView.animateWithDuration(1) {
            
            self.uLabel.frame = CGRect(x: 0, y: yCoord, width: 75, height: 75)
            self.uLabel.alpha = 1
            
            self.iLabel.frame = CGRect(x: labelDimension, y: yCoord, width: 75, height: 75)
            self.iLabel.alpha = 1
            
            self.z1Label.frame = CGRect(x: labelDimension * 2, y: yCoord, width: 75, height: 75)
            self.z1Label.alpha = 1
            
            self.z2Label.frame = CGRect(x: labelDimension * 3, y: yCoord, width: 75, height: 75)
            self.z2Label.alpha = 1
            
            self.aLabel.frame = CGRect(x: labelDimension * 4, y: yCoord, width: 75, height: 75)
            self.aLabel.alpha = 1
            
            self.pLabel.frame = CGRect(x: labelDimension * 5, y: yCoord, width: 75, height: 75)
            self.pLabel.alpha = 1
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


