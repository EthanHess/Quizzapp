//
//  SubjectListViewController.swift
//  Quizzapp
//
//  Created by Ethan Hess on 1/18/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

import UIKit

class SubjectListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView = UITableView!()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //maybe change to custom popout view later
        
        let addButton = UIBarButtonItem(title: "+", style: UIBarButtonItemStyle.Plain, target: self, action: "addSubject")
        self.navigationItem.rightBarButtonItem = addButton

        self.tableView = UITableView(frame: self.view.bounds, style: UITableViewStyle.Grouped)
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //eventually add custom cell which shows current score
        
        var cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell!
        cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        
        let subject = CardController.sharedInstance.subjects[indexPath.row] as Subject!
        
        cell.textLabel?.text = subject.name
        cell.detailTextLabel?.text = NSString(format: "%f Cards", (subject.cards?.count)!) as String
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return CardController.sharedInstance.subjects.count
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
        
        let subject = CardController.sharedInstance.subjects[indexPath.row] as Subject!
        
        let subjectDetailVC = SubjectDetailViewController()
        
        subjectDetailVC.subject = subject
        
        self.navigationController?.pushViewController(subjectDetailVC, animated: true)
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
