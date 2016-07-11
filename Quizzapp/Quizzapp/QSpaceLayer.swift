//
//  QSpaceLayer.swift
//  Quizzapp
//
//  Created by Ethan Hess on 4/18/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

import UIKit

class QSpaceLayer: CAShapeLayer {
    
    let animationDuration: CFTimeInterval = 0.3
    
    override init() {
        super.init()
        
        defaultImageView()
        
//        establishBackground()
        path = centerCirclePathSmall.CGPath
    }
    
//    func establishBackground() {
//        
//        if (scheme() != nil) {
//            
//            if scheme() == space {
//                
//                defaultImageView()
//                
//            } else if scheme() == nature {
//                
//                customImageView()
//                
//            } else {
//                
//                defaultImageView()
//                
//            }
//            
//        } else {
//            
//            defaultImageView()
//        }
//    
//    }
    
    func defaultImageView() {
        
        fillColor = UIColor(patternImage: UIImage(named: "mainQBackground")!).CGColor
    }
    
//    func customImageView() {
//    
//        fillColor = UIColor(patternImage: UIImage(named: "QSpaceNature")!).CGColor
//    }
    
//    func scheme() -> String? {
//        
//        return NSUserDefaults.standardUserDefaults().objectForKey(schemeKey) as? String
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var centerCirclePathSmall: UIBezierPath {
        
        return UIBezierPath(ovalInRect: CGRect(x: 125.0, y: 125.0, width: 0.0, height: 0.0))
    }
    
    var centerCirclePathLarge: UIBezierPath {
        
        return UIBezierPath(ovalInRect: CGRect(x: 20.0, y: 20.0, width: 210.0, height: 210.0))
    }
    
    func expandAgain() {
        
        let expandAnimation: CABasicAnimation = CABasicAnimation(keyPath: "path")
        
        expandAnimation.fromValue = centerCirclePathSmall.CGPath
        expandAnimation.toValue = centerCirclePathLarge.CGPath
        expandAnimation.duration = animationDuration
        expandAnimation.fillMode = kCAFillModeForwards
        expandAnimation.removedOnCompletion = false
        
        addAnimation(expandAnimation, forKey: nil)
        
    }
}
