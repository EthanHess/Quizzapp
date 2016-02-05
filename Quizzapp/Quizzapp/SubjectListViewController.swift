//
//  SubjectListViewController.swift
//  Quizzapp
//
//  Created by Ethan Hess on 1/18/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

import UIKit

class SubjectListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate, UITextFieldDelegate {
    
    var tableView = UITableView!()
    var textField : UITextField!
    var textView : UITextView!
    var addCardButton : UIButton!
    var clearButton : UIButton!
    var titleLabel : UILabel!
    var dismissButton : UIButton!
    var subjectToAdd : Subject?
    
    var addCardView : UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerForNotifications()
        
        //maybe change to custom popout view later
        
        let addButton = UIBarButtonItem(title: "+", style: UIBarButtonItemStyle.Plain, target: self, action: "addSubject")
        self.navigationItem.rightBarButtonItem = addButton

        self.tableView = UITableView(frame: self.view.bounds, style: UITableViewStyle.Grouped)
        self.tableView.registerClass(TableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        
        self.addCardView = UIView(frame: CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height / 2))
        self.addCardView.backgroundColor = UIColor.whiteColor()
        self.addCardView.layer.cornerRadius = 10
        self.addCardView.layer.borderColor = UIColor.blackColor().CGColor
        self.addCardView.layer.borderWidth = 2
        
        titleLabel = UILabel(frame: CGRectMake(100, 25, self.addCardView.frame.size.width - 200, 50))
        titleLabel.textAlignment = NSTextAlignment.Center
        addCardView.addSubview(titleLabel)
        
        textField = UITextField(frame: CGRectMake(100, 90, self.addCardView.frame.size.width - 200, 50))
        textField.placeholder = "Add Question"
        textField.delegate = self
        textField.borderStyle = UITextBorderStyle.RoundedRect
        textField.layer.borderColor = UIColor.darkGrayColor().CGColor
        textField.layer.borderWidth = 2
        addCardView.addSubview(textField)
        
        textView = UITextView(frame: CGRectMake(100, 155, self.addCardView.frame.size.width - 200, 100))
        textView.delegate = self
        textView.layer.cornerRadius = 10
        textView.layer.borderColor = UIColor.darkGrayColor().CGColor
        textView.layer.borderWidth = 2
        addCardView.addSubview(textView)
        
        addCardButton = UIButton(frame: CGRectMake(100, 270, 60, 60))
        addCardButton.setTitle("Add", forState: UIControlState.Normal)
        addCardButton.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        addCardButton.addTarget(self, action: "addCard", forControlEvents: UIControlEvents.TouchUpInside)
        addCardButton.layer.cornerRadius = 30
        addCardButton.layer.borderWidth = 2
        addCardButton.layer.borderColor = UIColor.darkGrayColor().CGColor
        addCardView.addSubview(addCardButton)
        
        clearButton = UIButton(frame: CGRectMake(self.addCardView.frame.size.width / 2 - 30, 270, 60, 60))
        clearButton.setTitle("Clear", forState: UIControlState.Normal)
        clearButton.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        clearButton.addTarget(self, action: "clearFields", forControlEvents: UIControlEvents.TouchUpInside)
        clearButton.layer.cornerRadius = 30
        clearButton.layer.borderWidth = 2
        clearButton.layer.borderColor = UIColor.darkGrayColor().CGColor
        addCardView.addSubview(clearButton)
        
        dismissButton = UIButton(frame: CGRectMake(self.addCardView.frame.size.width - 160, 270, 60, 60))
        dismissButton.setTitle(">", forState: UIControlState.Normal)
        dismissButton.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        dismissButton.addTarget(self, action: "dismissAddView", forControlEvents: UIControlEvents.TouchUpInside)
        dismissButton.layer.cornerRadius = 30
        dismissButton.layer.borderWidth = 2
        dismissButton.layer.borderColor = UIColor.darkGrayColor().CGColor
        addCardView.addSubview(dismissButton)
        
        self.view.addSubview(self.addCardView)
        
    }
    
    func registerForNotifications() {
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshTable", name: "refresh", object: nil)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //eventually add custom cell which shows current score
        
        let cell : TableViewCell = tableView.dequeueReusableCellWithIdentifier("cell") as! TableViewCell!
//        cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        
        let subject = CardController.sharedInstance.subjects[indexPath.row] as Subject!
        
        cell.titleLabel.text = subject.name!
        
        cell.scoreLabel?.text = NSString(format: "right: %i, wrong: %i", Int(subject.trueCount!), Int(subject.falseCount!)) as String
        
        cell.cardCountLabel?.text = NSString(format: "%d Cards", (subject.cards?.count)!) as String
        
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
            self.tableView.reloadData()
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
        
        print(subject.name)
        
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
        
        //check to see if fields are empty
        
        print(subjectToAdd)
        
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
            self.tableView.center = self.view.center
            self.navigationController?.navigationBarHidden = false
            self.tableView.alpha = 1
            
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        textField.resignFirstResponder()
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
