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
        
        self.backgroundColor = UIColor.lightGrayColor()
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.darkGrayColor().CGColor
        
        questionLabel = UILabel(frame: CGRectMake(10, 20, self.frame.size.width - 20, 100))
        questionLabel.text = "Quiz question"
        questionLabel.backgroundColor = UIColor.whiteColor()
        questionLabel.layer.masksToBounds = true
        questionLabel.layer.cornerRadius = 10
        questionLabel.layer.borderColor = UIColor.whiteColor().CGColor
        questionLabel.layer.borderWidth = 2
        self.addSubview(questionLabel)
        
        answerLabel = UILabel(frame: CGRectMake(10, 20, self.frame.size.width - 20, 100))
        answerLabel.text = "Quiz answer"
        answerLabel.backgroundColor = UIColor.whiteColor()
        answerLabel.layer.masksToBounds = true
        answerLabel.layer.cornerRadius = 10
        answerLabel.layer.borderColor = UIColor.whiteColor().CGColor
        answerLabel.layer.borderWidth = 2
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
    
    
//    override func drawRect(rect: CGRect) {
//        
//    }


}
