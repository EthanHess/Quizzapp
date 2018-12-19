//
//  QSpaceLayer.swift
//  Quizzapp
//
//  Created by Ethan Hess on 4/18/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

import UIKit

class QSpaceLayer: CAShapeLayer {
    
    let animationDuration: CFTimeInterval = 1
    
    override init() {
        super.init()
        defaultImageView()
        path = centerCirclePathSmall.cgPath
    }
    
    func defaultImageView() {
        fillColor = UIColor(patternImage: UIImage(named: "mainQBackground")!).cgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var centerCirclePathSmall: UIBezierPath {
        return UIBezierPath(ovalIn: CGRect(x: 125.0, y: 125.0, width: 0.0, height: 0.0))
    }
    
    var centerCirclePathLarge: UIBezierPath {
        return UIBezierPath(ovalIn: CGRect(x: 20.0, y: 20.0, width: 210.0, height: 210.0))
    }
    
    func expandAgain() {
        let expandAnimation: CABasicAnimation = CABasicAnimation(keyPath: "path")
        
        expandAnimation.fromValue = centerCirclePathSmall.cgPath
        expandAnimation.toValue = centerCirclePathLarge.cgPath
        expandAnimation.duration = animationDuration
        expandAnimation.fillMode = kCAFillModeForwards
        expandAnimation.isRemovedOnCompletion = false
        
        add(expandAnimation, forKey: nil)
        
    }
}
