//
//  QContainerView.swift
//  Quizzapp
//
//  Created by Ethan Hess on 4/18/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

import UIKit

class QContainerView: UIView {
    
    let qLayer = QLayer()
    let spaceLayer = QSpaceLayer()
    
    var parentFrame : CGRect = CGRectZero
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.clearColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func expandCircle() {
        
        layer.addSublayer(qLayer)
        qLayer.expand()
        
    }
    
    func expandSmallerCircle() {
        
        layer.addSublayer(spaceLayer)
        spaceLayer.expandAgain()
        
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(QContainerView.drawQLine), userInfo: nil, repeats: false)
        
    }
    
    func drawQLine() {
        
        
        print("HEY WORLD")
        
        
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
