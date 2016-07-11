//
//  SubjectDetailViewController.swift
//  Quizzapp
//
//  Created by Ethan Hess on 1/19/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

import UIKit

class SubjectDetailViewController: UIViewController {
    
    var draggableView : DraggableView!
    var subject : Subject!
    var currentCard : Card?
    var cardArray = [Card]()
    var selectedCardIndex = 0
    var wrongArray : [Bool] = []
    var rightArray : [Bool] = []
    
    var rightLabel : UILabel!
    var wrongLabel : UILabel!
    
    func updateWithSubject(subject: Subject) {
        
        if let subject = self.subject {
            
            self.subject = subject
            
            self.title = self.subject.name
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(SubjectDetailViewController.popToRoot))
        self.navigationItem.leftBarButtonItem = newBackButton;
        
        self.draggableView = DraggableView(frame: CGRectMake(50, 100, self.view.frame.size.width - 100, self.view.frame.size.height - 200))
        self.view.addSubview(self.draggableView)
        
        rightWrongLabels()
        
        setUpView()
        
        if self.subject.cards?.count == 0 {
            
            let alertController = UIAlertController(title: "No cards!", message: "There are no cards yet in this stack, please add one", preferredStyle: UIAlertControllerStyle.Alert)
      
            let action = UIAlertAction(title: "Okay!", style: .Cancel, handler: { (action) in
                
                self.popToRoot()
            })
            
            alertController.addAction(action)
            
            presentViewController(alertController, animated: true, completion: nil)
            
        }
        
        let imageView = UIImageView(frame: view.bounds)
        imageView.image = UIImage(named: "cardViewBackground")
        view.insertSubview(imageView, atIndex: 0)
        
    }
    
    func popToRoot() {
        
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    func rightWrongLabels() {
        
        rightLabel = UILabel(frame: CGRectMake(50, self.view.frame.size.height / 2 - 50, self.view.frame.size.width - 100, 100))
        rightLabel.backgroundColor = UIColor.clearColor()
        rightLabel.text = "Right!"
        rightLabel.textColor = Colors().rightLabelColor
        rightLabel.textAlignment = NSTextAlignment.Center
        rightLabel.font = UIFont(name: cFont, size: 48)
        rightLabel.hidden = true
        self.view.addSubview(rightLabel)
        
        wrongLabel = UILabel(frame: CGRectMake(50, self.view.frame.size.height / 2 - 50, self.view.frame.size.width - 100, 100))
        wrongLabel.backgroundColor = UIColor.clearColor()
        wrongLabel.text = "Wrong!"
        wrongLabel.textColor = Colors().rightLabelColor
        wrongLabel.textAlignment = NSTextAlignment.Center
        wrongLabel.font = UIFont(name: cFont, size: 48)
        wrongLabel.hidden = true
        self.view.addSubview(wrongLabel)
    }
    
    func flipCard() {
        
        UIView.transitionWithView(draggableView, duration: 1, options: UIViewAnimationOptions.TransitionFlipFromRight, animations: { () -> Void in
            
            self.draggableView.flipCard()
            
            }, completion: nil)
    }
    
    
    func dragView(gesture: UIPanGestureRecognizer) {
        
        //moves view
        
        let translation = gesture.translationInView(self.view)
        let dragView = gesture.view!
        
        dragView.center = CGPoint(x: self.view.bounds.width / 2 + translation.x, y: self.view.bounds.height + translation.y)
        
        let xFromCenter = dragView.center.x - self.view.bounds.width / 2
        
        let scale = min(100 / abs(xFromCenter), 1)
        
        var rotation = CGAffineTransformMakeRotation(xFromCenter / 200)
        var stretch = CGAffineTransformScale(rotation, scale, scale)
        
        dragView.transform = stretch
        
        //change background color accordingly 
        
        if dragView.center.x < 150 {
            
            wrongLabel.hidden = false
            wrongLabel.alpha = 0.5
            rightLabel.hidden = true
            
            performSelector(#selector(SubjectDetailViewController.hideWrongLabel), withObject: nil, afterDelay: 1)
            
        }
        
        if dragView.center.x > self.view.bounds.width - 150 {
            
            rightLabel.hidden = false
            rightLabel.alpha = 0.5
            wrongLabel.hidden = true
            
            performSelector(#selector(SubjectDetailViewController.hideRightLabel), withObject: nil, afterDelay: 1)
            
        }
        
        //decifer whether answer was wrong or right
        
        if gesture.state == UIGestureRecognizerState.Ended {
            
            //TODO create boolean variable for answer
            
            if dragView.center.x < 100 {
                
                print("wrong")
                
                self.wrongArray.append(false)
                self.playSoundWithBool(false)
            }
            
            else if dragView.center.x > self.view.bounds.width - 100 {
                
                print("right")
                
                self.rightArray.append(true)
                self.playSoundWithBool(true)
            }
            
            //save boolean to current card
            
            //resetting dragView
            rotation = CGAffineTransformMakeRotation(0)
            stretch = CGAffineTransformScale(rotation, 1, 1)
            dragView.transform = stretch
            dragView.center = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2)
            
            //call update card
            
            updateCard()
        }
    }
    
    func hideWrongLabel() {
        
        wrongLabel.hidden = true
    }
    
    func hideRightLabel() {
        
        rightLabel.hidden = true
    }
    
    func playSoundWithBool(right: Bool) {
        
        let urlRight = NSBundle.mainBundle().URLForResource("right", withExtension: "wav")
        let urlWrong = NSBundle.mainBundle().URLForResource("wrong", withExtension: "wav")
        
        if right {
            
            SoundController.sharedManager.playAudioFileAtURL(urlRight!)
            
        } else {
            
            SoundController.sharedManager.playAudioFileAtURL(urlWrong!)
            
        }
    }
    
    func updateCard() {
        
        let cardCount = (self.subject.cards?.array.count)! - 2
        
        if self.selectedCardIndex <= cardCount {
            
            self.selectedCardIndex += 1
            self.currentCard = self.subject.cards?.array[self.selectedCardIndex] as? Card
            self.draggableView.questionLabel.text = self.currentCard?.question
            self.draggableView.answerLabel.text = self.currentCard?.answer
            
            //flip it back over
            if self.draggableView.isFlipped == true {
                
                draggableView.flipCard()
            }
        
        } else {
            
             CardController.sharedInstance.addFalseCountToSubject(self.subject, falseCount: wrongArray.count)
             CardController.sharedInstance.addTrueCountToSubject(self.subject, trueCount: rightArray.count)
            
            //reload VC table view
            
             NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "refresh", object: nil))

             let alertController = UIAlertController(title: "Finished", message: String(format: "You got %i right and %i wrong", rightArray.count, wrongArray.count), preferredStyle: UIAlertControllerStyle.Alert)
            
            let okayAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
                
                self.setUpView()
            })
            
            alertController.addAction(okayAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        
    }
    
    func setUpView() {
        
        selectedCardIndex = 0
        
        wrongArray.removeAll(keepCapacity: true)
        rightArray.removeAll(keepCapacity: true)
        
        wrongLabel.hidden = true
        rightLabel.hidden = true
        
        self.updateWithSubject(self.subject!)
        
        //TODO: Clear array here
        
        if let firstCard = self.subject?.cards?.array.first as? Card {
            self.currentCard = firstCard
        }
        
        self.draggableView.questionLabel.text = self.currentCard?.question
        self.draggableView.answerLabel.text = self.currentCard?.answer
        
        //flip it back over
        if self.draggableView.isFlipped == true {
            
            draggableView.flipCard()
        }
        
        let dragGesture = UIPanGestureRecognizer(target: self, action: #selector(SubjectDetailViewController.dragView(_:)))
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SubjectDetailViewController.flipCard))
        draggableView.addGestureRecognizer(tapGesture)
        draggableView.addGestureRecognizer(dragGesture)
    }
    
    //TODO: make function displaying alert according to score

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
