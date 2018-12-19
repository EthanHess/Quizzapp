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
        
        determineImage()

        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.layer.borderColor = Colors().cardLineColor.cgColor
        self.layer.borderWidth = 1
        
        questionLabel = UILabel(frame: CGRect(x: 10, y: 20, width: self.frame.size.width - 20, height: 250))
        questionLabel.numberOfLines = 0
        questionLabel.textColor = Colors().cardTextColor
        questionLabel.font = UIFont(name: cFont, size: 16)
        questionLabel.textAlignment = NSTextAlignment.center
        questionLabel.backgroundColor = Colors().cardLabelBackgroundColor
        questionLabel.layer.masksToBounds = true
        questionLabel.layer.cornerRadius = 10
        self.addSubview(questionLabel)
        
        answerLabel = UILabel(frame: CGRect(x: 10, y: 20, width: self.frame.size.width - 20, height: 250))
        answerLabel.numberOfLines = 0
        answerLabel.textColor = Colors().cardTextColor
        answerLabel.font = UIFont(name: cFont, size: 16)
        answerLabel.textAlignment = NSTextAlignment.center
        answerLabel.backgroundColor = Colors().cardLabelBackgroundColor
        answerLabel.layer.masksToBounds = true
        answerLabel.layer.cornerRadius = 10
        answerLabel.isHidden = true
        self.addSubview(answerLabel)
    }
    
    func determineImage() {
        if (scheme() != nil) {
            if scheme() == space {
                standardBackground()
            } else if scheme() == nature {
                customBackground()
            } else {
                standardBackground()
            }
        } else {
            standardBackground()
        }
    }
    
    func scheme() -> String? {
        return UserDefaults.standard.object(forKey: schemeKey) as? String
    }
    
    func standardBackground() {
        let imageView = UIImageView(frame: self.bounds)
        imageView.image = UIImage(named: "cardBackground")
        imageView.layer.masksToBounds =  true
        addSubview(imageView)
    }
    
    func customBackground() {
        let imageView = UIImageView(frame: self.bounds)
        imageView.image = UIImage(named: "NatureCardBackground")
        imageView.layer.masksToBounds =  true
        addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func flipCard() {
        if isFlipped == false {
            questionLabel.isHidden = true
            answerLabel.isHidden = false
            isFlipped = true
        } else {
            questionLabel.isHidden = false
            answerLabel.isHidden = true
            isFlipped = false
        }
    }
}
