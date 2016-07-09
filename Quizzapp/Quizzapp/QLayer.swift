//
//  QLayer.swift
//  Quizzapp
//
//  Created by Ethan Hess on 4/18/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

import UIKit

class QLayer: CAShapeLayer {
    
    let animationDuration: CFTimeInterval = 1
    
    override init() {
        super.init()
        
        fillColor = Colors().qLineColor.CGColor
        path = qPathSmall.CGPath
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var qPathSmall: UIBezierPath {
        return UIBezierPath(ovalInRect: CGRect(x: 125.0, y: 125.0, width: 0.0, height: 0.0))
    }
    
    var qPathLarge: UIBezierPath {
        return UIBezierPath(ovalInRect: CGRect(x: 0.0, y: 0.0, width: 250.0, height: 250.0))
    }
    
    
    func expand() {
        
        let expandAnimation: CABasicAnimation = CABasicAnimation(keyPath: "path")
        
        expandAnimation.fromValue = qPathSmall.CGPath
        expandAnimation.toValue = qPathLarge.CGPath
        expandAnimation.duration = animationDuration
        expandAnimation.fillMode = kCAFillModeForwards
        expandAnimation.removedOnCompletion = false
        
        addAnimation(expandAnimation, forKey: nil)
    }

}
