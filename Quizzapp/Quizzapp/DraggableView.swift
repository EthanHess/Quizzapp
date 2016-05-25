//
//  DraggableView.swift
//  Quizzapp
//
//  Created by Ethan Hess on 1/17/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

import UIKit

class DraggableView: UIView {
    
    var isFlipped = false
    var questionLabel = UILabel()
    var answerLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let imageView = UIImageView(frame: self.bounds)
        imageView.image = UIImage(named: "cardBackground")
        imageView.layer.masksToBounds =  true
        addSubview(imageView)

        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.layer.borderColor = Colors().cardLineColor.CGColor
        self.layer.borderWidth = 1
        
        questionLabel = UILabel(frame: CGRectMake(10, 20, self.frame.size.width - 20, 250))
        questionLabel.numberOfLines = 0
        questionLabel.textColor = Colors().cardTextColor
        questionLabel.font = UIFont(name: cFont, size: 16)
        questionLabel.textAlignment = NSTextAlignment.Center
        questionLabel.backgroundColor = Colors().cardLabelBackgroundColor
        questionLabel.layer.masksToBounds = true
        questionLabel.layer.cornerRadius = 10
        self.addSubview(questionLabel)
        
        answerLabel = UILabel(frame: CGRectMake(10, 20, self.frame.size.width - 20, 250))
        answerLabel.numberOfLines = 0
        answerLabel.textColor = Colors().cardTextColor
        answerLabel.font = UIFont(name: cFont, size: 16)
        answerLabel.textAlignment = NSTextAlignment.Center
        answerLabel.backgroundColor = Colors().cardLabelBackgroundColor
        answerLabel.layer.masksToBounds = true
        answerLabel.layer.cornerRadius = 10
        answerLabel.hidden = true
        self.addSubview(answerLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func flipCard() {
        
        if isFlipped == false {
            
            questionLabel.hidden = true
            answerLabel.hidden = false
            
            isFlipped = true
        }
        
        else {
            
            questionLabel.hidden = false
            answerLabel.hidden = true
            
            isFlipped = false
        }
        
    }
    

}
