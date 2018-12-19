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
            return
        } else {
            calculateFinalGrade()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.backgroundColor = UIColor.darkGray
    }
    
    func noSubjects() -> Bool {
        return CardController.sharedInstance.subjects.count == 0
    }
    
    func setUpViews() {
        
        let tableViewFrame = CGRect(x: 0, y: 80, width: self.view.frame.size.width, height: self.view.frame.size.height - 80)
        
        scoreTableView = UITableView(frame: tableViewFrame, style: .grouped)
        scoreTableView.delegate = self
        scoreTableView.dataSource = self
        scoreTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        scoreTableView.backgroundColor = UIColor(red: 4/255, green: 42/255, blue: 84/255, alpha: 1.0)
        self.view.addSubview(scoreTableView)
        
        let buttonFrame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 80)
        
        dismissButton = UIButton(frame: buttonFrame)
        dismissButton.setTitle("Dismiss", for: UIControlState())
        dismissButton.backgroundColor = UIColor.black
        dismissButton.setTitleColor(UIColor.white, for: UIControlState())
        dismissButton.addTarget(self, action: #selector(ScoreListViewController.dismissSelf), for: .touchUpInside)
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
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Subject")
        fetchRequest.returnsObjectsAsFaults = false
        
        let goodGradeSort = NSSortDescriptor(key: "grade", ascending: false)
        fetchRequest.sortDescriptors = [goodGradeSort]
        
        guard let objects = try! Stack.sharedInstance.managedObjectContext.fetch(fetchRequest) as? [Subject] else { return [] }
        
        return objects
    }
    
    func dismissSelf() {
        self.dismiss(animated: true, completion: nil)
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sortClassesOnGrade().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        let subject = self.sortClassesOnGrade()[indexPath.row]
        
        cell?.textLabel?.text = subject.name
        cell?.backgroundColor = Colors().niceBlue
        cell?.textLabel?.textColor = UIColor.white
        cell?.detailTextLabel?.textColor = UIColor.white
        
        if subject.grade != nil {
            cell?.detailTextLabel?.text = String(subject.grade!.int32Value)
            cell?.imageView?.image = determineImage(Float(subject.grade!))
        }
        else if subject.trueCount == 0 && subject.falseCount == 0 {
            cell?.imageView?.image = UIImage(named: "NoGrade")
        }
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func determineImage(_ grade: Float) -> UIImage {
        if grade < 60 {
            return UIImage(named: "F")!
        }
        else if grade >= 60 && grade < 70 {
            return UIImage(named: "D")!
        }
        else if grade >= 70 && grade < 80 {
            return UIImage(named: "C")!
        }
        else if grade >= 80 && grade < 90 {
            return UIImage(named: "B")!
        }
        else {
            return UIImage(named: "A")!
        }
    }
}
