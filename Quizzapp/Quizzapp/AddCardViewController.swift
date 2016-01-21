//
//  AddCardViewController.swift
//  Quizzapp
//
//  Created by Ethan Hess on 1/19/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

import UIKit

class AddCardViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    var subject : Subject?
    var questionTextField = UITextField()
    var answerTextField = UITextView()
    var saveButton = UIButton()
    var clearButton = UIButton()
    
    func updateWithSubject(subject: Subject) {
        
        if let subject = self.subject {
            
            self.subject = subject
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()

        questionTextField = UITextField(frame: CGRectMake(20, 100, self.view.frame.size.width - 40, 50))
        questionTextField.delegate = self
        questionTextField.placeholder = "Add Question"
        questionTextField.layer.cornerRadius = 10
        questionTextField.layer.borderColor = UIColor.blackColor().CGColor
        questionTextField.layer.borderWidth = 3
        self.view.addSubview(questionTextField)
        
        answerTextField = UITextView(frame: CGRectMake(20, 200, self.view.frame.size.width - 40, 200))
        answerTextField.delegate = self
        answerTextField.layer.borderWidth = 3
        answerTextField.layer.borderColor = UIColor.blackColor().CGColor
        answerTextField.layer.cornerRadius = 10
        self.view.addSubview(answerTextField)
        
        clearButton = UIButton(frame: CGRectMake(20, 450, 80, 80))
        clearButton.setTitle("Clear", forState: UIControlState.Normal)
        clearButton.addTarget(self, action: "clear", forControlEvents: UIControlEvents.TouchUpInside)
        clearButton.backgroundColor = UIColor.lightGrayColor()
        clearButton.layer.cornerRadius = 40
        clearButton.layer.borderColor = UIColor.whiteColor().CGColor
        clearButton.layer.borderWidth = 3
        self.view.addSubview(clearButton)
        
        saveButton = UIButton(frame: CGRectMake(self.view.frame.size.width - 100, 450, 80, 80))
        saveButton.setTitle("Save", forState: UIControlState.Normal)
        saveButton.addTarget(self, action: "save", forControlEvents: UIControlEvents.TouchUpInside)
        saveButton.backgroundColor = UIColor.lightGrayColor()
        saveButton.layer.cornerRadius = 40
        saveButton.layer.borderColor = UIColor.whiteColor().CGColor
        saveButton.layer.borderWidth = 3
        self.view.addSubview(saveButton)
    }
    
    //implement textview delegate method here
    
    func save() {
        
        //check to see if fields are empty
        
        CardController.sharedInstance.addCardToSubject(self.subject!, questiion: questionTextField.text!, answer: answerTextField.text!)
    }
    
    func clear() {
        
        self.questionTextField.text = ""
        self.answerTextField.text = ""
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        textField.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
