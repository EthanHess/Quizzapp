//
//  ScoreListViewController.swift
//  Quizzapp
//
//  Created by Ethan Hess on 8/26/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

import UIKit
import CoreData

class ScoreListViewController: UIViewController {
    
    var scoreTableView : UITableView!
    var segControl : UISegmentedControl!
    var dismissButton : UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if noSubjects() {
            print("Nada") //pop an alert eventually
        }

        else {
            calculateFinalGrade()
        }
    }
    
    func noSubjects() -> Bool {
        
        return CardController.sharedInstance.subjects.count == 0
    }
    
    func setUpViews() {
        
        let tableViewFrame = CGRectMake(0, 80, self.view.frame.size.width, self.view.frame.size.height - 80)
        
        scoreTableView = UITableView(frame: tableViewFrame, style: .Grouped)
        scoreTableView.delegate = self
        scoreTableView.dataSource = self
        scoreTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(scoreTableView)
        
        let buttonFrame = CGRectMake(0, 0, self.view.frame.size.width, 80)
        
        dismissButton = UIButton(frame: buttonFrame)
        dismissButton.setTitle("Dismiss", forState: .Normal)
        dismissButton.backgroundColor = UIColor.blackColor()
        dismissButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        dismissButton.addTarget(self, action: #selector(ScoreListViewController.dismiss), forControlEvents: .TouchUpInside)
        self.view.addSubview(dismissButton)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func calculateFinalGrade() {
        
        let subjects = CardController.sharedInstance.subjects
        
        for subject in subjects {
            
            let yes = Float(subject.trueCount!)
            let no = Float(subject.falseCount!)
            
            print("yes and no: \(yes) \(no)")
            
            let totalPoints = yes + no
            
            print("total points: \(totalPoints)")
            
            let finalGrade = Float(yes / totalPoints)
            let finalGradeMultiplied = finalGrade * 100
            
            print("final grade: \(finalGrade) --- \(finalGradeMultiplied)")
            
            //set grade property in core data
            
            CardController.sharedInstance.addGradeToSubject(subject, grade: finalGradeMultiplied)
            
            setUpViews()
        }
    }
    
    func sortClassesOnGrade() -> Array<Subject> {
        
        let fetchRequest = NSFetchRequest(entityName: "Subject")
        fetchRequest.returnsObjectsAsFaults = false
        
        let goodGradeSort = NSSortDescriptor(key: "grade", ascending: false)
        fetchRequest.sortDescriptors = [goodGradeSort]
        
        guard let objects = try! Stack.sharedInstance.managedObjectContext.executeFetchRequest(fetchRequest) as? [Subject] else { return [] }
        
        return objects
    }
    
    func dismiss() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        dismiss()
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

extension ScoreListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.sortClassesOnGrade().count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        
        cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "cell")
        
        let subject = self.sortClassesOnGrade()[indexPath.row]
        
        cell?.textLabel?.text = subject.name
        cell?.detailTextLabel?.text = String(subject.grade)
        
        return cell!
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
