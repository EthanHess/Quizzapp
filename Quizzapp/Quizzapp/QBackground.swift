//
//  QBackground.swift
//  Quizzapp
//
//  Created by Ethan Hess on 2/29/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

import UIKit

class QBackground: UIView {
    
    var backgroundRect : UIView!
    var qImageView : UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        self.backgroundColor = UIColor.whiteColor()
        
        self.backgroundRect = UIView(frame: self.bounds)
        self.backgroundRect.backgroundColor = UIColor.whiteColor()
//        self.sendSubviewToBack(self.backgroundRect)
        
        self.qImageView = UIImageView(frame: self.bounds)
        self.qImageView.image = UIImage(named: "QBackground")
//        self.bringSubviewToFront(self.qImageView)
        
        self.addSubview(self.backgroundRect)
        self.addSubview(self.qImageView)
        
    }
    
    func animateBackroundRect() {
        
        UIView.animateWithDuration(0.5) { () -> Void in
            
            self.backgroundRect.frame = CGRectMake(0, 0, 0, self.frame.size.height)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
