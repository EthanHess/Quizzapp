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
    var textField : UITextField!
    var textView : UITextView!
    var addCardButton : UIButton!
    var clearButton : UIButton!
    var titleLabel : UILabel!
    var dismissButton : UIButton!
    var subjectToAdd : Subject?
    
    var addCardView : UIView!
    var addInstructionsImageView : UIImageView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerForNotifications()
        
        //maybe change to custom popout view later
        
        let addButton = UIBarButtonItem(title: "+", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(SubjectListViewController.addSubject))
        self.navigationItem.rightBarButtonItem = addButton

        self.tableView = UITableView(frame: CGRectMake(50, 80, self.view.frame.size.width - 100, self.view.frame.size.height), style: UITableViewStyle.Grouped)
        self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableView.registerClass(TableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        
        self.addCardView = UIView(frame: CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height / 2))
        self.addCardView.layer.cornerRadius = 10
        self.addCardView.layer.borderColor = Colors().cardTextColor.CGColor
        self.addCardView.layer.borderWidth = 2
        self.addCardView.layer.masksToBounds = true
        
        let imageBG = UIImageView(frame: addCardView.bounds)
        imageBG.image = UIImage(named: "quizCellBackground")
        addCardView.addSubview(imageBG)
        
        titleLabel = UILabel(frame: CGRectMake(25, 25, self.addCardView.frame.size.width - 50, 50))
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.font = UIFont(name: cFont, size: 42)
        addCardView.addSubview(titleLabel)
        
        textField = UITextField(frame: CGRectMake(100, 90, self.addCardView.frame.size.width - 200, 50))
        textField.placeholder = "Add Question"
        textField.delegate = self
        textField.borderStyle = UITextBorderStyle.RoundedRect
        textField.layer.borderColor = UIColor.darkGrayColor().CGColor
        textField.layer.borderWidth = 1
        addCardView.addSubview(textField)
        
        textView = UITextView(frame: CGRectMake(100, 155, self.addCardView.frame.size.width - 200, 100))
        textView.delegate = self
        textView.layer.cornerRadius = 10
        textView.layer.borderColor = UIColor.whiteColor().CGColor
        textView.layer.borderWidth = 1
        addCardView.addSubview(textView)
        
        addCardButton = UIButton(frame: CGRectMake(100, 270, 45, 45))
        addCardButton.titleLabel?.font = UIFont(name: cFont, size: 12)
        addCardButton.setTitle("Add", forState: UIControlState.Normal)
        addCardButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        addCardButton.addTarget(self, action: #selector(SubjectListViewController.addCard), forControlEvents: UIControlEvents.TouchUpInside)
        addCardButton.layer.cornerRadius = 22.5
        addCardButton.layer.borderWidth = 1
        addCardButton.layer.borderColor = UIColor.whiteColor().CGColor
        addCardView.addSubview(addCardButton)
        
        clearButton = UIButton(frame: CGRectMake(self.addCardView.frame.size.width / 2 - 22.5, 270, 45, 45))
        clearButton.titleLabel?.font = UIFont(name: cFont, size: 12)
        clearButton.setTitle("Clear", forState: UIControlState.Normal)
        clearButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        clearButton.addTarget(self, action: #selector(SubjectListViewController.clearFields), forControlEvents: UIControlEvents.TouchUpInside)
        clearButton.layer.cornerRadius = 22.5
        clearButton.layer.borderWidth = 1
        clearButton.layer.borderColor = UIColor.whiteColor().CGColor
        addCardView.addSubview(clearButton)
        
        dismissButton = UIButton(frame: CGRectMake(self.addCardView.frame.size.width - 145, 270, 45, 45))
        dismissButton.titleLabel?.font = UIFont(name: cFont, size: 18)
        dismissButton.setTitle(">", forState: UIControlState.Normal)
        dismissButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        dismissButton.addTarget(self, action: #selector(SubjectListViewController.dismissAddView), forControlEvents: UIControlEvents.TouchUpInside)
        dismissButton.layer.cornerRadius = 22.5
        dismissButton.layer.borderWidth = 1
        dismissButton.layer.borderColor = UIColor.whiteColor().CGColor
        addCardView.addSubview(dismissButton)
        
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
        
        let imageView = UIImageView(frame: view.bounds)
        imageView.image = UIImage(named: "listBackground")
        view.insertSubview(imageView, atIndex: 0)
        
    }
    
    func noSubjects() -> Bool {
        
        return CardController.sharedInstance.subjects.count == 0
    }
    
    //remember to dealloc
    
    func registerForNotifications() {
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SubjectListViewController.refreshTable), name: "refresh", object: nil)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell : TableViewCell = tableView.dequeueReusableCellWithIdentifier("cell") as! TableViewCell!
        
        let subject = CardController.sharedInstance.subjects[indexPath.row] as Subject!
        
        let right = Int(subject.trueCount!)
        let wrong = Int(subject.falseCount!)
        
        cell.setGradePicture(right, wrong: wrong)
        cell.setRightAndWrongCount(right, wrong: wrong)
        
        cell.titleLabel.text = subject.name!
        
        cell.scoreLabel.text = NSString(format: "right: %i, wrong: %i", Int(subject.trueCount!), Int(subject.falseCount!)) as String
        
        cell.cardCountLabel.text = NSString(format: "%d Cards", (subject.cards?.count)!) as String
        
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
            
            CardController.sharedInstance.addSubjectWithName(nameField.text!)
            self.addInstructionsImageView.hidden = true
            self.refreshTable()
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
        
        //pop out add card view etc.
        
        UIView.animateWithDuration(0.5) { () -> Void in
            
            self.addCardView.center = CGPointMake(self.view.center.x, self.addCardView.center.y)
            self.tableView.center = CGPointMake(self.view.center.x, self.view.center.y + self.view.frame.size.height - self.addCardView.frame.size.height)
            self.titleLabel.text = subject.name
            self.navigationController?.navigationBarHidden = true
            self.tableView.alpha = 0.5
        }
        
    }
    
    func addCard() {
        
        CardController.sharedInstance.addCardToSubject(self.subjectToAdd!, questiion: self.textField.text!, answer: self.textView.text)
        
        tableView.reloadData()
        dismissAddView()
        clearFields()
    }
    
    func clearFields() {
        
        textField.text = ""
        textView.text = ""
        
    }
    
    func dismissAddView() {
        
        UIView.animateWithDuration(0.5) { () -> Void in
            
            self.addCardView.center = CGPointMake(self.view.center.x + self.view.frame.size.width, self.addCardView.center.y)
            self.tableView.center = CGPointMake(self.view.center.x, self.view.center.y + 80)
            self.navigationController?.navigationBarHidden = false
            self.tableView.alpha = 1
            
        }
    }
    
//    func textFieldDidEndEditing(textField: UITextField) {
//        
//        textField.resignFirstResponder()
//    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        addCard()
        
        textField.resignFirstResponder()
        
        return true
    }
    
    //add text view delegate
    
    func refreshTable() {
        
        tableView.reloadData()
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
