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
    
    //Middle animation
    var animationContainer : UIView = {
        let theView = UIView()
        theView.backgroundColor = .clear
        return theView
    }()
    
    //Left and right orbs
    var animationViewLeft : UIView = {
        let leftView = UIView()
        leftView.backgroundColor = .white
        leftView.alpha = 0.5
        return leftView
    }()
    
    var animationViewRight : UIView = {
        let rightView = UIView()
        rightView.backgroundColor = .cyan
        rightView.alpha = 0.5
        return rightView
    }()
    
    //Top and bottom orbs
    var animationViewTop : UIView = {
        let leftView = UIView()
        leftView.backgroundColor = .blue
        leftView.alpha = 0.5
        return leftView
    }()
    
    var animationViewBottom : UIView = {
        let rightView = UIView()
        rightView.backgroundColor = .magenta
        rightView.alpha = 0.5
        return rightView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let barButtonItem = UIBarButtonItem(title: "Classes", style: UIBarButtonItem.Style.plain, target: self, action: #selector(ViewController.pushToDetailView))
        self.navigationItem.rightBarButtonItem = barButtonItem
        
        let onboardBarButtonItem = UIBarButtonItem(title: "Settings", style: UIBarButtonItem.Style.plain, target: self, action: #selector(ViewController.presentOnboarding))
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
        //imageView.image = UIImage(named: "mainQBackground")
        imageView.image = UIImage(named: "QAPiPhone") //TODO check for ipad
        view.addSubview(imageView)
    }
    
    func scheme() -> String? {
        return UserDefaults.standard.object(forKey: schemeKey) as? String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bigBangSound()
    }
    
    func bigBangSound() {
        let url = Bundle.main.url(forResource: "grandOpening", withExtension: "wav")
        SoundController.sharedManager.playAudioFileAtURL(url!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
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
        
        animationContainerSetUp()
    }
    
    //TODO add anchor extension
    fileprivate func animationContainerSetUp() {
        animationContainer.frame = CGRect(x: 50, y: (view.frame.size.height / 2) - 50, width: view.frame.size.width - 100, height: 100)
        
        //Left and right
        animationViewLeft.frame = CGRect(x: 20, y: 20, width: 60, height: 60)
        cornerRadiusForSubviews(theSV: animationViewLeft)
        animationContainer.addSubview(animationViewLeft)
        
        animationViewRight.frame = CGRect(x: animationContainer.frame.size.width - 80, y: 20, width: 60, height: 60)
        cornerRadiusForSubviews(theSV: animationViewRight)
        animationContainer.addSubview(animationViewRight)
        
        //Top and bottom
        animationViewTop.frame = CGRect(x: (animationContainer.frame.size.width / 2) - 10, y: 5, width: 20, height: 20)
        cornerRadiusForSubviews(theSV: animationViewTop)
        animationContainer.addSubview(animationViewTop)
        
        animationViewBottom.frame = CGRect(x: (animationContainer.frame.size.width / 2) - 10, y: animationContainer.frame.size.height - 25, width: 20, height: 20)
        cornerRadiusForSubviews(theSV: animationViewBottom)
        animationContainer.addSubview(animationViewBottom)
        
        view.addSubview(animationContainer)
        
        beginOrbAnimation()
        beginTopBottomOrbAnimation()
    }
    
    fileprivate func cornerRadiusForSubviews(theSV: UIView) {
        theSV.layer.cornerRadius = theSV.frame.size.width / 2
        theSV.layer.masksToBounds = true
    }
    
    fileprivate func beginOrbAnimation() {
        UIView.animate(withDuration: 2, animations: {
            self.animationViewRight.frame = self.animationViewLeft.frame
            self.animationViewLeft.frame = CGRect(x: self.animationContainer.frame.size.width - 80, y: 20, width: 60, height: 60)
        }) { (completed) in
            self.animationViewRight.frame = CGRect(x: self.animationContainer.frame.size.width - 80, y: 20, width: 60, height: 60)
            self.animationViewLeft.frame = CGRect(x: 20, y: 20, width: 60, height: 60)
        }
    }
    
    //D.R.Y frame code in computed property once correct coordinates are established, also make sure they return when VC is refreshed (when user leaves and comes back)
    fileprivate func beginTopBottomOrbAnimation() {
        UIView.animate(withDuration: 1, animations: {
            self.animationViewTop.frame = CGRect(x: (self.animationContainer.frame.size.width / 2) - 10, y: self.animationContainer.frame.size.height - 25, width: 20, height: 20)
            self.animationViewBottom.frame = CGRect(x: (self.animationContainer.frame.size.width / 2) - 10, y: 5, width: 20, height: 20)
        }) { (completed) in
            self.animationViewBottom.frame = CGRect(x: (self.animationContainer.frame.size.width / 2) - 10, y: self.animationContainer.frame.size.height - 25, width: 20, height: 20)
            self.animationViewTop.frame = CGRect(x: (self.animationContainer.frame.size.width / 2) - 10, y: 5, width: 20, height: 20)
            self.beginTopBottomOrbAnimation()
        }
    }
    
    func expandSpaceInQ() {
        qTainerView.expandSmallerCircle()
    }

    @objc func pushToDetailView() {
        let subjectView = SubjectListViewController()
        self.navigationController?.pushViewController(subjectView, animated: true)
    }
    
    @objc func presentOnboarding() {
        let creditsViewController = CreditsViewController()
        self.navigationController?.pushViewController(creditsViewController, animated: true)
    }

    func setUpOtherLetters() {
        if (scheme() != nil) {
            if scheme() == space {
                labelColor = Colors().niceBlue
            } else if scheme() == nature {
                //labelColor = UIColor.black
                labelColor = Colors().niceBlue
            } else {
                labelColor = Colors().niceBlue
            }
        } else {
            labelColor = Colors().niceBlue
        }
        
        let labelDimension : CGFloat = self.view.frame.size.width / 6
        
        uLabel.frame = CGRect(x: -labelDimension * 3, y: view.bounds.height - 150, width: labelDimension, height: labelDimension)
        uLabel.alpha = 0
        uLabel.text = "U"
        uLabel.textAlignment = NSTextAlignment.center
        uLabel.font = UIFont(name: "Arial-Hebrew", size: 84)
        uLabel.sizeToFit()
        uLabel.textColor = labelColor
        uLabel.backgroundColor = UIColor.clear
        
        iLabel.frame = CGRect(x: -labelDimension * 2, y: view.bounds.height - 150, width: labelDimension, height: labelDimension)
        iLabel.alpha = 0
        iLabel.text = "I"
        iLabel.textAlignment = NSTextAlignment.center
        iLabel.font = UIFont(name: "Arial-Hebrew", size: 84)
        iLabel.sizeToFit()
        iLabel.textColor = labelColor
        iLabel.backgroundColor = UIColor.clear
        
        z1Label.frame = CGRect(x: -labelDimension, y: view.bounds.height - 150, width: labelDimension, height: labelDimension)
        z1Label.alpha = 0
        z1Label.text = "Z"
        z1Label.textAlignment = NSTextAlignment.center
        z1Label.font = UIFont(name: "Arial-Hebrew", size: 84)
        z1Label.sizeToFit()
        z1Label.textColor = labelColor
        z1Label.backgroundColor = UIColor.clear
        
        z2Label.frame = CGRect(x: view.bounds.width + labelDimension * 2, y: view.bounds.height - 150, width: labelDimension, height: labelDimension)
        z2Label.alpha = 0
        z2Label.text = "Z"
        z2Label.textAlignment = NSTextAlignment.center
        z2Label.font = UIFont(name: "Arial-Hebrew", size: 84)
        z2Label.sizeToFit()
        z2Label.textColor = labelColor
        z2Label.backgroundColor = UIColor.clear
        
        aLabel.frame = CGRect(x: view.bounds.width + labelDimension, y: view.bounds.height - 150, width: labelDimension, height: labelDimension)
        aLabel.alpha = 0
        aLabel.text = "A"
        aLabel.textAlignment = NSTextAlignment.center
        aLabel.font = UIFont(name: "Arial-Hebrew", size: 84)
        aLabel.sizeToFit()
        aLabel.textColor = labelColor
        aLabel.backgroundColor = UIColor.clear
        
        pLabel.frame = CGRect(x: view.bounds.width, y: view.bounds.height - 150, width: labelDimension, height: labelDimension)
        pLabel.alpha = 0
        pLabel.text = "P"
        pLabel.textAlignment = NSTextAlignment.center
        pLabel.font = UIFont(name: "Arial-Hebrew", size: 84)
        pLabel.sizeToFit()
        pLabel.textColor = labelColor
        pLabel.backgroundColor = UIColor.clear
        
        labelStylizer(theLabel: uLabel)
        labelStylizer(theLabel: iLabel)
        labelStylizer(theLabel: z1Label)
        labelStylizer(theLabel: z2Label)
        labelStylizer(theLabel: aLabel)
        labelStylizer(theLabel: pLabel)
        
        view.addSubview(uLabel)
        view.addSubview(iLabel)
        view.addSubview(z1Label)
        view.addSubview(z2Label)
        view.addSubview(aLabel)
        view.addSubview(pLabel)
        
        animateLabels()
    }
    
    fileprivate func labelStylizer(theLabel: UILabel) {
        theLabel.backgroundColor = .black
        theLabel.layer.cornerRadius = 37.5
        theLabel.layer.borderColor = Colors().niceBlue.cgColor
        theLabel.layer.borderWidth = 1
        theLabel.layer.masksToBounds = true
    }
    
    func animateLabels() {
        
        let yCoord = view.bounds.height - 150
        let labelDimension = self.view.frame.size.width / 6
        
        UIView.animate(withDuration: 1, animations: {
            
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
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


