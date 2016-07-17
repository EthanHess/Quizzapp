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
    let qImageView = UIImageView()
    
    var parentFrame : CGRect = CGRectZero
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.clearColor()
        
        qImageView.frame = CGRectMake(self.bounds.width, self.bounds.height, 0, 0)
        qImageView.image = UIImage(named: "QLine")
        self.bringSubviewToFront(qImageView)
        self.addSubview(qImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func expandCircle() {
        
        layer.insertSublayer(qLayer, atIndex: 0)
        qLayer.expand()
        
    }
    
    func expandSmallerCircle() {

        layer.insertSublayer(spaceLayer, atIndex: 1)
        spaceLayer.expandAgain()
        
        NSTimer.scheduledTimerWithTimeInterval(0.3, target: self, selector: #selector(QContainerView.drawQLine), userInfo: nil, repeats: false)
        
    }
    
    func drawQLine() {
        
        UIView.animateWithDuration(1) {
            
           self.qImageView.frame = CGRectMake(self.bounds.width / 2, self.bounds.height / 2, self.bounds.width / 2, self.bounds.height / 2)
        }
        
        
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
