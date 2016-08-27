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

    override func viewDidLoad() {
        super.viewDidLoad()

        let array = sortClassesOnGrade()
        
        print(array)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sortClassesOnGrade() -> Array<Subject> {

        let fetchRequest = NSFetchRequest(entityName: "Subject")
        fetchRequest.returnsObjectsAsFaults = false
        
        let goodGradeSort = NSSortDescriptor(key: "trueCount", ascending: false)
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
