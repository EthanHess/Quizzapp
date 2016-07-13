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
        
        let labelFrame = CGRectMake(0, 0, self.frame.size.width, 80)
        let textFieldFrame = CGRectMake(50, 80, self.frame.size.width - 100, 50)
        let textViewFrame = CGRectMake(50, 150, self.frame.size.width - 100, 90)
        let buttonOneFrame = CGRectMake(buttonWidth, 260, buttonWidth, buttonWidth)
        let buttonTwoFrame = CGRectMake(buttonWidth * 3, 260, buttonWidth, buttonWidth)
        let buttonThreeFrame = CGRectMake(buttonWidth * 5, 260, buttonWidth, buttonWidth)
        
        titleLabel = UILabel(frame: labelFrame)
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.font = UIFont(name: cFont, size: 36)
        self.addSubview(titleLabel)
        
        textField = UITextField(frame: textFieldFrame)
        textField.placeholder = "Add Question"
        textField.borderStyle = UITextBorderStyle.RoundedRect
        textField.layer.borderColor = UIColor.darkGrayColor().CGColor
        textField.layer.borderWidth = 1
        self.addSubview(textField)
        
        textView = UITextView(frame: textViewFrame)
        textView.layer.cornerRadius = 10
        textView.layer.borderColor = UIColor.whiteColor().CGColor
        textView.layer.borderWidth = 1
        self.addSubview(textView)
        
        addCardButton = UIButton(frame: buttonOneFrame)
        addCardButton.titleLabel?.font = UIFont(name: cFont, size: 12)
        addCardButton.setTitle("Add", forState: UIControlState.Normal)
        addCardButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
//        addCardButton.addTarget(self, action: #selector(SubjectListViewController.addCard), forControlEvents: UIControlEvents.TouchUpInside)
        addCardButton.layer.cornerRadius = buttonWidth / 2
        addCardButton.layer.borderWidth = 1
        addCardButton.layer.borderColor = UIColor.whiteColor().CGColor
        self.addSubview(addCardButton)
        
        clearButton = UIButton(frame: buttonTwoFrame)
        clearButton.titleLabel?.font = UIFont(name: cFont, size: 12)
        clearButton.setTitle("Clear", forState: UIControlState.Normal)
        clearButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
//        clearButton.addTarget(self, action: #selector(SubjectListViewController.clearFields), forControlEvents: UIControlEvents.TouchUpInside)
        clearButton.layer.cornerRadius = buttonWidth / 2
        clearButton.layer.borderWidth = 1
        clearButton.layer.borderColor = UIColor.whiteColor().CGColor
        self.addSubview(clearButton)

        dismissButton = UIButton(frame: buttonThreeFrame)
        dismissButton.titleLabel?.font = UIFont(name: cFont, size: 18)
        dismissButton.setTitle(">", forState: UIControlState.Normal)
        dismissButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
//        dismissButton.addTarget(self, action: #selector(SubjectListViewController.dismissAddView), forControlEvents: UIControlEvents.TouchUpInside)
        dismissButton.layer.cornerRadius = buttonWidth / 2
        dismissButton.layer.borderWidth = 1
        dismissButton.layer.borderColor = UIColor.whiteColor().CGColor
        self.addSubview(dismissButton)

    }
    
    func scheme() -> String? {
        
        return NSUserDefaults.standardUserDefaults().objectForKey(schemeKey) as? String
    }
    
    func standardBackground() {
        
        let imageView = UIImageView(frame: self.bounds)
        imageView.image = UIImage(named: "quizCellBackground")
        imageView.layer.masksToBounds =  true
        self.insertSubview(imageView, atIndex: 0)
        
    }
    
    func customBackground() {
        
        let imageView = UIImageView(frame: self.bounds)
        imageView.image = UIImage(named: "WoodCell")
        imageView.layer.masksToBounds =  true
        self.insertSubview(imageView, atIndex: 0)
        
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
