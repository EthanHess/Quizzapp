//
//  SubjectDetailViewController.swift
//  Quizzapp
//
//  Created by Ethan Hess on 1/19/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

import UIKit

class SubjectDetailViewController: UIViewController {
    
    var draggableView = DraggableView!()
    var subject : Subject!
    var currentCard : Card?
    var cardArray = [Card]()
    var selectedCardIndex = 0
    var wrongArray : [Bool] = []
    var rightArray : [Bool] = []
    
    func updateWithSubject(subject: Subject) {
        
        if let subject = self.subject {
            self.subject = subject
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        setUpBarButtonItem()
        
        self.draggableView = DraggableView(frame: CGRectMake(50, 100, self.view.frame.size.width - 100, self.view.frame.size.height - 200))
        self.view.addSubview(self.draggableView)
        
        setUpView()
        
    }
    
    func flipCard() {
        
        UIView.transitionWithView(draggableView, duration: 1, options: UIViewAnimationOptions.TransitionFlipFromRight, animations: { () -> Void in
            
            self.draggableView.flipCard()
            
            }, completion: nil)
    }
    
    func setUpBarButtonItem() {
        
        let addButton = UIBarButtonItem(title: "+", style: UIBarButtonItemStyle.Plain, target: self, action: "pushToAddDetailView")
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    func pushToAddDetailView() {
        
        print("Hello World!")
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
        
        //decifer whether answer was wrong or right
        
        if gesture.state == UIGestureRecognizerState.Ended {
            
            //TODO create boolean variable for answer
            
            if dragView.center.x < 100 {
                
                print("wrong")
                
                self.wrongArray.append(false)
            }
            
            else if dragView.center.x > self.view.bounds.width - 100 {
                
                print("right")
                
                self.rightArray.append(true)
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
    
    
    func updateCard() {
        
        let cardCount = (self.subject.cards?.array.count)! - 2
        
        if self.selectedCardIndex <= cardCount {
            
            self.selectedCardIndex += 1
            self.currentCard = self.subject.cards?.array[self.selectedCardIndex] as? Card
            self.draggableView.questionLabel.text = self.currentCard?.question
            self.draggableView.answerLabel.text = self.currentCard?.answer
        
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
        
        self.updateWithSubject(self.subject!)
        
        //TODO: Clear array here
        
        if let firstCard = self.subject?.cards?.array.first as? Card {
            self.currentCard = firstCard
        }
        
        self.draggableView.questionLabel.text = self.currentCard?.question
        self.draggableView.answerLabel.text = self.currentCard?.answer
        
        let dragGesture = UIPanGestureRecognizer(target: self, action: "dragView:")
        let tapGesture = UITapGestureRecognizer(target: self, action: "flipCard")
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
