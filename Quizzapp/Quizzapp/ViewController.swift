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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: #selector(ViewController.pushToDetailView))
        self.navigationItem.rightBarButtonItem = barButtonItem
        
        let onboardBarButtonItem = UIBarButtonItem(title: "Instructions", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(ViewController.presentOnboarding))
        self.navigationItem.leftBarButtonItem = onboardBarButtonItem
        
        self.view.backgroundColor = Colors().viewBackgroundColor
        
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
        view.addSubview(qTainerView)
        
        qTainerView.expandCircle()
        
        performSelector(#selector(ViewController.expandSpaceInQ), withObject: nil, afterDelay: 0.5)
        
    }
    
    func expandSpaceInQ() {
        
        qTainerView.expandSmallerCircle()
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

    func setUpOtherLetters() {
        
        //set alpha to 0 to make look cooler
        
        let labelDimension : CGFloat = 75
        
        uLabel.frame = CGRect(x: -225, y: view.bounds.height - 150, width: labelDimension, height: labelDimension)
        uLabel.alpha = 0
        uLabel.text = "U"
        uLabel.textAlignment = NSTextAlignment.Center
        uLabel.font = UIFont(name: "Arial-Hebrew", size: 84)
        uLabel.sizeToFit()
        uLabel.textColor = UIColor.whiteColor()
        uLabel.backgroundColor = Colors().viewBackgroundColor
        
        iLabel.frame = CGRect(x: -150, y: view.bounds.height - 150, width: labelDimension, height: labelDimension)
        iLabel.alpha = 0
        iLabel.text = "I"
        iLabel.textAlignment = NSTextAlignment.Center
        iLabel.font = UIFont(name: "Arial-Hebrew", size: 84)
        iLabel.sizeToFit()
        iLabel.textColor = UIColor.whiteColor()
        iLabel.backgroundColor = Colors().viewBackgroundColor
        
        z1Label.frame = CGRect(x: -75, y: view.bounds.height - 150, width: labelDimension, height: labelDimension)
        z1Label.alpha = 0
        z1Label.text = "Z"
        z1Label.textAlignment = NSTextAlignment.Center
        z1Label.font = UIFont(name: "Arial-Hebrew", size: 84)
        z1Label.sizeToFit()
        z1Label.textColor = UIColor.whiteColor()
        z1Label.backgroundColor = Colors().viewBackgroundColor
        
        z2Label.frame = CGRect(x: view.bounds.width + 150, y: view.bounds.height - 150, width: labelDimension, height: labelDimension)
        z2Label.alpha = 0
        z2Label.text = "Z"
        z2Label.textAlignment = NSTextAlignment.Center
        z2Label.font = UIFont(name: "Arial-Hebrew", size: 84)
        z2Label.sizeToFit()
        z2Label.textColor = UIColor.whiteColor()
        z2Label.backgroundColor = Colors().viewBackgroundColor
        
        aLabel.frame = CGRect(x: view.bounds.width + 75, y: view.bounds.height - 150, width: labelDimension, height: labelDimension)
        aLabel.alpha = 0
        aLabel.text = "A"
        aLabel.textAlignment = NSTextAlignment.Center
        aLabel.font = UIFont(name: "Arial-Hebrew", size: 84)
        aLabel.sizeToFit()
        aLabel.textColor = UIColor.whiteColor()
        aLabel.backgroundColor = Colors().viewBackgroundColor
        
        pLabel.frame = CGRect(x: view.bounds.width, y: view.bounds.height - 150, width: labelDimension, height: labelDimension)
        pLabel.alpha = 0
        pLabel.text = "P"
        pLabel.textAlignment = NSTextAlignment.Center
        pLabel.font = UIFont(name: "Arial-Hebrew", size: 84)
        pLabel.sizeToFit()
        pLabel.textColor = UIColor.whiteColor()
        pLabel.backgroundColor = Colors().viewBackgroundColor
        
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
        
        UIView.animateWithDuration(1) {
            
            //TODO: Make coordinates exact/even
            
            self.uLabel.frame = CGRect(x: 0, y: yCoord, width: 75, height: 75)
            self.uLabel.alpha = 1
            
            self.iLabel.frame = CGRect(x: 75, y: yCoord, width: 75, height: 75)
            self.iLabel.alpha = 1
            
            self.z1Label.frame = CGRect(x: 150, y: yCoord, width: 75, height: 75)
            self.z1Label.alpha = 1
            
            self.z2Label.frame = CGRect(x: 225, y: yCoord, width: 75, height: 75)
            self.z2Label.alpha = 1
            
            self.aLabel.frame = CGRect(x: 300, y: yCoord, width: 75, height: 75)
            self.aLabel.alpha = 1
            
            self.pLabel.frame = CGRect(x: 375, y: yCoord, width: 75, height: 75)
            self.pLabel.alpha = 1
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


