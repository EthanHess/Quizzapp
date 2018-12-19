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
    
    var parentFrame : CGRect = CGRect.zero
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.clear
        
        qImageView.frame = CGRect(x: self.bounds.width, y: self.bounds.height, width: 0, height: 0)
        qImageView.image = UIImage(named: "QLine")
        self.bringSubview(toFront: qImageView)
        self.addSubview(qImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func expandCircle() {
        layer.insertSublayer(qLayer, at: 0)
        qLayer.expand()
    }
    
    func expandSmallerCircle() {
        layer.insertSublayer(spaceLayer, at: 1)
        spaceLayer.expandAgain()
        Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(QContainerView.drawQLine), userInfo: nil, repeats: false)
    }
    
    func drawQLine() {
        UIView.animate(withDuration: 1, animations: {
           self.qImageView.frame = CGRect(x: self.bounds.width / 2, y: self.bounds.height / 2, width: self.bounds.width / 2, height: self.bounds.height / 2)
        }) 
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
