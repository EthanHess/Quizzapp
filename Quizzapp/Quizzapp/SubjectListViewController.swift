//
//  SubjectListViewController.swift
//  Quizzapp
//
//  Created by Ethan Hess on 1/18/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

import UIKit

class SubjectListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate, UITextFieldDelegate {
    
    var tableView : UITableView!
    var subjectToAdd : Subject?
    var addCardView : AddView!
    var addInstructionsImageView : UIImageView!
    var addViewFrame : CGRect?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        registerForNotifications()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //maybe change to custom popout view later
        
        let addButton = UIBarButtonItem(title: "Add Class", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(SubjectListViewController.addSubject))
        //self.navigationItem.rightBarButtonItem = addButton
        
        let scoreButton = UIBarButtonItem(title: "See Scores", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(SubjectListViewController.presentScores))
        
        self.navigationItem.rightBarButtonItems = [addButton, scoreButton]

        self.tableView = UITableView(frame: CGRectMake(50, 80, self.view.frame.size.width - 100, self.view.frame.size.height), style: UITableViewStyle.Grouped)
        self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableView.registerClass(TableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        
        //make view bigger for iphone 4 (480) and 5 (568)
        
        if screenHeight == 480 {
            
            addViewFrame = CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height / 2 + 150)
            
        } else if screenHeight == 568 {
            
            addViewFrame = CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height / 2 + 100)
            
            
        } else {
            
            addViewFrame = CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height / 2)
            
        }
        
        self.addCardView = AddView(frame: addViewFrame!)
    
        self.addCardView.layer.cornerRadius = 10
        self.addCardView.layer.borderColor = Colors().cardTextColor.CGColor
        self.addCardView.layer.borderWidth = 2
        self.addCardView.layer.masksToBounds = true
        self.addCardView.textView.delegate = self
        self.addCardView.textField.delegate = self
        
        self.addCardView.addCardButton.addTarget(self, action: #selector(SubjectListViewController.addCard), forControlEvents: UIControlEvents.TouchUpInside)
        self.addCardView.clearButton.addTarget(self, action: #selector(SubjectListViewController.clearFields), forControlEvents: .TouchUpInside)
        self.addCardView.dismissButton.addTarget(self, action: #selector(SubjectListViewController.dismissAddView), forControlEvents: .TouchUpInside)
        
        
        self.view.addSubview(self.addCardView)
        
        //add instructions imageView 
        
        addInstructionsImageView = UIImageView(frame: CGRectMake(80, 200, self.view.frame.size.width - 160, self.view.frame.size.height - 300))
        addInstructionsImageView.image = UIImage(named: "QAddBackground")
        
        if self.noSubjects() {
            addInstructionsImageView.hidden = false
        }
        
        else {
            
            addInstructionsImageView.hidden = true
        }
        
        view.insertSubview(addInstructionsImageView, atIndex: 1)
        
        //determine BG via scheme
        
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
    
    func presentScores() {
        
        let scoreList = ScoreListViewController()
        self.presentViewController(scoreList, animated: true, completion: nil)
    }
    
    func scheme() -> String? {
        
        return NSUserDefaults.standardUserDefaults().objectForKey(schemeKey) as? String
    }

    func standardBackground() {
        
        let imageView = UIImageView(frame: view.bounds)
        imageView.image = UIImage(named: "listBackground")
        view.insertSubview(imageView, atIndex: 0)
    }
    
    func customBackground() {
        
        let imageView = UIImageView(frame: view.bounds)
        imageView.image = UIImage(named: "NatureListBG")
        view.insertSubview(imageView, atIndex: 0)
    }
    
    func noSubjects() -> Bool {
        
        return CardController.sharedInstance.subjects.count == 0
    }
    
    //remember to dealloc
    
    func registerForNotifications() {
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SubjectListViewController.refreshTable), name: "refresh", object: nil)
    }
    
    deinit { //could do in view did disappear?
        
        print("Notification observation being removed")
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell : TableViewCell = tableView.dequeueReusableCellWithIdentifier("cell") as! TableViewCell!
        
        let subject = CardController.sharedInstance.subjects[indexPath.row] as Subject!
        
        let right = Int(subject.trueCount!)
        let wrong = Int(subject.falseCount!)
        
        //clear out image views to prevent overlap
        
        cell.bgImageRight.image = nil
        cell.bgImageWrong.image = nil
        cell.gradeImage.image = nil
        
        cell.setGradePicture(right, wrong: wrong)
        cell.setRightAndWrongCount(right, wrong: wrong)
        
        cell.titleLabel.text = subject.name!
        
        cell.scoreLabel.text = NSString(format: "right: %i, wrong: %i", Int(subject.trueCount!), Int(subject.falseCount!)) as String
        
        if (subject.cards?.count == 1) {
            
            cell.cardCountLabel.text = NSString(format: "%d Card", (subject.cards?.count)!) as String
        }
        else {
            
        cell.cardCountLabel.text = NSString(format: "%d Cards", (subject.cards?.count)!) as String
            
        }
        
        cell.layer.cornerRadius = 10
        cell.layer.borderColor = UIColor.lightGrayColor().CGColor
        cell.layer.borderWidth = 2
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return CardController.sharedInstance.subjects.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 260
    }
    
    func addSubject() {
        
        let alertController = UIAlertController(title: "Add subject", message: "For quiz stack", preferredStyle: UIAlertControllerStyle.Alert)
        
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
            
            textField.placeholder = "Subject title"
        }
        
        let alertAction = UIAlertAction(title: "Save", style: UIAlertActionStyle.Default) { (action) -> Void in
            
            let nameField = alertController.textFields![0]
            
            if nameField.text != "" {
            
            CardController.sharedInstance.addSubjectWithName(nameField.text!)
            self.addInstructionsImageView.hidden = true
            self.refreshTable()
                
            } else {
                
                self.displayAlert("Please add a title", message: "")
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) { (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(alertAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //make sure if card count == 0 that an alert pops up telling them to add at least one card
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let subject = CardController.sharedInstance.subjects[indexPath.row] as Subject!
        self.subjectToAdd = subject
        
        let alertController = UIAlertController(title: "Options", message: "Add card or start quiz", preferredStyle: UIAlertControllerStyle.Alert)
        let alertAction = UIAlertAction(title: "Add Card", style: UIAlertActionStyle.Default) { (action) -> Void in
            
            self.popOutAddCardViewWithSubject(subject)

        }
        
        let viewAction = UIAlertAction(title: "Start Quiz!", style: UIAlertActionStyle.Default) { (action) -> Void in
            
            let subjectDetailVC = SubjectDetailViewController()
            
            subjectDetailVC.subject = subject
            
            self.navigationController?.pushViewController(subjectDetailVC, animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) { (action) -> Void in
            
            //cancels self
        }
        
        alertController.addAction(alertAction)
        alertController.addAction(viewAction)
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)

    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            
            CardController.sharedInstance.removeSubject(CardController.sharedInstance.subjects[indexPath.row])
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
        
    }
    
    func popOutAddCardViewWithSubject(subject: Subject) {
        
        //can't interact with cells when add view is popped out
        self.tableView.userInteractionEnabled = false
        
        if subject.cards?.count > 15 {
            
            self.displayAlert("There are already 15 cards in this class", message: "Feel free to start another")
        }
        
        else {
        
        //pop out add card view etc.
        
        UIView.animateWithDuration(0.5) { () -> Void in
            
            self.addCardView.center = CGPointMake(self.view.center.x, self.addCardView.center.y)
            self.tableView.center = CGPointMake(self.view.center.x, self.view.center.y + self.view.frame.size.height - self.addCardView.frame.size.height)
            
            self.addCardView.titleLabel.text = subject.name

            self.navigationController?.navigationBarHidden = true
            self.tableView.alpha = 0.5
        }
        }
        
    }
    
    func addCard() {
        
        if self.addCardView.textView.text != "" && self.addCardView.textField.text != "" {
        
        CardController.sharedInstance.addCardToSubject(self.subjectToAdd!, question: self.self.addCardView.textField.text!, answer: self.self.addCardView.textView.text)
        
        tableView.reloadData()
        dismissAddView()
        clearFields()
            
        } else {
            
            self.displayAlert("Add a valid question and answer", message: "")
        }
        
    }
    
    func clearFields() {
        
        self.addCardView.textField.text = ""
        self.addCardView.textView.text = ""
        
    }
    
    func dismissAddView() {
        
        self.tableView.userInteractionEnabled = true
        
        UIView.animateWithDuration(0.5) { () -> Void in
            
            self.addCardView.center = CGPointMake(self.view.center.x + self.view.frame.size.width, self.addCardView.center.y)
            self.tableView.center = CGPointMake(self.view.center.x, self.view.center.y + 80)
            self.navigationController?.navigationBarHidden = false
            self.tableView.alpha = 1
            
        }
    }
    

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
//        addCard()
        
        textField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        textField.resignFirstResponder()
    }
    
    //weird text view delegate
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    //self explanatory
    
    func refreshTable() {
        
        tableView.reloadData()
    }
    
    func displayAlert(title: String, message: String) {
        
        let alertCon = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        let okayAction = UIAlertAction(title: "Okay!", style: .Cancel, handler: nil)
        
        alertCon.addAction(okayAction)
        
        presentViewController(alertCon, animated: true, completion: nil)
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
