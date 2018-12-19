//
//  AddView.swift
//  Quizzapp
//
//  Created by Ethan Hess on 7/13/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

import UIKit

class AddView: UIView {
    
    var textField : UITextField!
    var textView : UITextView!
    var addCardButton : UIButton!
    var clearButton : UIButton!
    var titleLabel : UILabel!
    var dismissButton : UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        determineImage()
        setUpViews()
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
    
    func setUpViews() {
        
        let buttonWidth = self.frame.size.width / 7
        
        let labelFrame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: 80)
        let textFieldFrame = CGRect(x: 50, y: 80, width: self.frame.size.width - 100, height: 50)
        let textViewFrame = CGRect(x: 50, y: 150, width: self.frame.size.width - 100, height: 90)
        let buttonOneFrame = CGRect(x: buttonWidth, y: 260, width: buttonWidth, height: buttonWidth)
        let buttonTwoFrame = CGRect(x: buttonWidth * 3, y: 260, width: buttonWidth, height: buttonWidth)
        let buttonThreeFrame = CGRect(x: buttonWidth * 5, y: 260, width: buttonWidth, height: buttonWidth)
        
        titleLabel = UILabel(frame: labelFrame)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont(name: cFont, size: 36)
        self.addSubview(titleLabel)
        
        textField = UITextField(frame: textFieldFrame)
        textField.placeholder = "Add Question"
        textField.borderStyle = UITextBorderStyle.roundedRect
        textField.layer.borderColor = UIColor.darkGray.cgColor
        textField.layer.borderWidth = 1
        self.addSubview(textField)
        
        textView = UITextView(frame: textViewFrame)
        textView.layer.cornerRadius = 10
        textView.layer.borderColor = UIColor.white.cgColor
        textView.layer.borderWidth = 1
        self.addSubview(textView)
        
        addCardButton = UIButton(frame: buttonOneFrame)
        addCardButton.titleLabel?.font = UIFont(name: cFont, size: 12)
        addCardButton.setTitle("Add", for: UIControlState())
        addCardButton.setTitleColor(UIColor.white, for: UIControlState())
//        addCardButton.addTarget(self, action: #selector(SubjectListViewController.addCard), forControlEvents: UIControlEvents.TouchUpInside)
        addCardButton.layer.cornerRadius = buttonWidth / 2
        addCardButton.layer.borderWidth = 1
        addCardButton.layer.borderColor = UIColor.white.cgColor
        self.addSubview(addCardButton)
        
        clearButton = UIButton(frame: buttonTwoFrame)
        clearButton.titleLabel?.font = UIFont(name: cFont, size: 12)
        clearButton.setTitle("Clear", for: UIControlState())
        clearButton.setTitleColor(UIColor.white, for: UIControlState())
//        clearButton.addTarget(self, action: #selector(SubjectListViewController.clearFields), forControlEvents: UIControlEvents.TouchUpInside)
        clearButton.layer.cornerRadius = buttonWidth / 2
        clearButton.layer.borderWidth = 1
        clearButton.layer.borderColor = UIColor.white.cgColor
        self.addSubview(clearButton)

        dismissButton = UIButton(frame: buttonThreeFrame)
        dismissButton.titleLabel?.font = UIFont(name: cFont, size: 18)
        dismissButton.setTitle(">", for: UIControlState())
        dismissButton.setTitleColor(UIColor.white, for: UIControlState())
//        dismissButton.addTarget(self, action: #selector(SubjectListViewController.dismissAddView), forControlEvents: UIControlEvents.TouchUpInside)
        dismissButton.layer.cornerRadius = buttonWidth / 2
        dismissButton.layer.borderWidth = 1
        dismissButton.layer.borderColor = UIColor.white.cgColor
        self.addSubview(dismissButton)

    }
    
    func scheme() -> String? {
        return UserDefaults.standard.object(forKey: schemeKey) as? String
    }
    
    func standardBackground() {
        let imageView = UIImageView(frame: self.bounds)
        imageView.image = UIImage(named: "quizCellBackground")
        imageView.layer.masksToBounds =  true
        self.insertSubview(imageView, at: 0)
    }
    
    func customBackground() {
        let imageView = UIImageView(frame: self.bounds)
        imageView.image = UIImage(named: "WoodCell")
        imageView.layer.masksToBounds =  true
        self.insertSubview(imageView, at: 0)
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
