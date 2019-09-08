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
    
    func updateWithSubject(_ subject: Subject) {
        if let subject = self.subject {
            self.subject = subject
            self.title = self.subject.name
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(SubjectDetailViewController.popToRoot))
        self.navigationItem.leftBarButtonItem = newBackButton;
        
        self.draggableView = DraggableView(frame: CGRect(x: 50, y: 100, width: self.view.frame.size.width - 100, height: self.view.frame.size.height - 200))
        self.view.addSubview(self.draggableView)
        
        rightWrongLabels()
        
        setUpView()
        
        if self.subject.cards?.count == 0 {
            let alertController = UIAlertController(title: "No cards!", message: "There are no cards yet in this stack, please add one", preferredStyle: UIAlertControllerStyle.alert)
            let action = UIAlertAction(title: "Okay!", style: .cancel, handler: { (action) in
                self.popToRoot()
            })
            alertController.addAction(action)
            present(alertController, animated: true, completion: nil)
        }
        
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
        let imageView = UIImageView(frame: view.bounds)
        imageView.image = UIImage(named: "galaxyWideBlue")
        view.insertSubview(imageView, at: 0)
    }
    
    func customBackground() {
        let imageView = UIImageView(frame: view.bounds)
        //imageView.image = UIImage(named: "DetailBackground")
        imageView.image = UIImage(named: "galaxyWideBlue") //TODO, find new nature pic
        view.insertSubview(imageView, at: 0)
    }
    
    //used to pop to root, rename function
    
    func popToRoot() {
        guard let navController = self.navigationController else {
            print("No NC \(self)")
            return
        }
        navController.popViewController(animated: true)
    }
    
    func rightWrongLabels() {
        
        rightLabel = UILabel(frame: CGRect(x: 50, y: self.view.frame.size.height / 2 - 50, width: self.view.frame.size.width - 100, height: 100))
        rightLabel.backgroundColor = UIColor.clear
        rightLabel.text = "Right!"
        rightLabel.textColor = Colors().rightLabelColor
        rightLabel.textAlignment = NSTextAlignment.center
        rightLabel.font = UIFont(name: cFont, size: 48)
        rightLabel.isHidden = true
        self.view.addSubview(rightLabel)
        
        wrongLabel = UILabel(frame: CGRect(x: 50, y: self.view.frame.size.height / 2 - 50, width: self.view.frame.size.width - 100, height: 100))
        wrongLabel.backgroundColor = UIColor.clear
        wrongLabel.text = "Wrong!"
        wrongLabel.textColor = Colors().rightLabelColor
        wrongLabel.textAlignment = NSTextAlignment.center
        wrongLabel.font = UIFont(name: cFont, size: 48)
        wrongLabel.isHidden = true
        self.view.addSubview(wrongLabel)
    }
    
    func flipCard() {
        UIView.transition(with: draggableView, duration: 1, options: UIViewAnimationOptions.transitionFlipFromRight, animations: { () -> Void in
            self.draggableView.flipCard()
            }, completion: nil)
    }
    
    
    func dragView(_ gesture: UIPanGestureRecognizer) {
        
        //moves view
        let translation = gesture.translation(in: self.view)
        let dragView = gesture.view!
        
        dragView.center = CGPoint(x: self.view.bounds.width / 2 + translation.x, y: self.view.bounds.height + translation.y)
        
        let xFromCenter = dragView.center.x - self.view.bounds.width / 2
        let scale = min(100 / abs(xFromCenter), 1)
        var rotation = CGAffineTransform(rotationAngle: xFromCenter / 200)
        var stretch = rotation.scaledBy(x: scale, y: scale)
        
        dragView.transform = stretch
        
        //change background color accordingly 
        
        if dragView.center.x < 150 {
            wrongLabel.isHidden = false
            wrongLabel.alpha = 0.5
            rightLabel.isHidden = true
            perform(#selector(SubjectDetailViewController.hideWrongLabel), with: nil, afterDelay: 1)
        }
        
        if dragView.center.x > self.view.bounds.width - 150 {
            rightLabel.isHidden = false
            rightLabel.alpha = 0.5
            wrongLabel.isHidden = true
            perform(#selector(SubjectDetailViewController.hideRightLabel), with: nil, afterDelay: 1)
        }
        
        //decifer whether answer was wrong or right
        
        if gesture.state == UIGestureRecognizerState.ended {
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
            rotation = CGAffineTransform(rotationAngle: 0)
            stretch = rotation.scaledBy(x: 1, y: 1)
            dragView.transform = stretch
            dragView.center = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2)
            //call update card
            updateCard()
        }
    }
    
    func hideWrongLabel() {
        wrongLabel.isHidden = true
    }
    
    func hideRightLabel() {
        rightLabel.isHidden = true
    }
    
    func playSoundWithBool(_ right: Bool) {
        let urlRight = Bundle.main.url(forResource: "right", withExtension: "wav")
        let urlWrong = Bundle.main.url(forResource: "wrong", withExtension: "wav")
        
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
             NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "refresh"), object: nil))
            
             let alertController = UIAlertController(title: "Finished", message: String(format: "You got %i right and %i wrong", rightArray.count, wrongArray.count), preferredStyle: UIAlertControllerStyle.alert)
            
            let okayAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.cancel, handler: { (action) -> Void in
                self.setUpView()
            })
            alertController.addAction(okayAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func setUpView() {

        selectedCardIndex = 0
        
        wrongArray.removeAll(keepingCapacity: true)
        rightArray.removeAll(keepingCapacity: true)
        
        wrongLabel.isHidden = true
        rightLabel.isHidden = true
        
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
