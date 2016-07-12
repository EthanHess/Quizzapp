//
//  CreditsViewController.swift
//  Quizzapp
//
//  Created by Ethan Hess on 7/8/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

import UIKit

let space = "Space"
let nature = "Nature"
let soundKey = "Sound"

let schemeKey = "Scheme"
var soundOn = true

class CreditsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView : UITableView!
    
    var segControl : UISegmentedControl!
    var soundButton : UIButton!
    
    var creditsArray = ["Song URLs, courtesy of Freesound.org", "https://www.freesound.org/people/Bertrof/sounds/131657/", "Other Sound"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.blackColor()
        
        let tableFrame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height / 2)

        self.tableView = UITableView(frame: tableFrame, style: .Grouped)
        self.tableView.backgroundColor = UIColor.blackColor()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "creditCell")
        self.view.addSubview(self.tableView)
        
        self.segControl = UISegmentedControl(items: ["Space Scheme", "Nature Scheme"])
        self.segControl.frame = CGRectMake(50, view.frame.size.height / 2 - 50, view.frame.size.width - 100, 50)
        self.segControl.tintColor = UIColor.whiteColor()
        
        self.segControl.addTarget(self, action: #selector(CreditsViewController.valueChanged(_:)), forControlEvents: .ValueChanged)
        self.view.addSubview(segControl)
        
        let buttonFrame = CGRectMake(50, self.view.frame.size.height / 2 + 50, view.frame.size.width - 100, 50)
        
        self.soundButton = UIButton(frame: buttonFrame)
        self.soundButton.setTitle("Turn off sound", forState: .Normal)
        self.soundButton.backgroundColor = UIColor.clearColor()
        self.soundButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.soundButton.addTarget(self, action: #selector(CreditsViewController.toggleSound), forControlEvents: .TouchUpInside)
        self.soundButton.layer.cornerRadius = 5
        self.soundButton.layer.borderColor = UIColor.whiteColor().CGColor
        self.soundButton.layer.borderWidth = 1
        self.view.addSubview(soundButton)
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return creditsArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("creditCell")
        
        cell?.textLabel?.text = creditsArray[indexPath.row]
        cell?.backgroundColor = UIColor.darkGrayColor()
        cell?.textLabel?.textColor = UIColor.greenColor()
        
        return cell!
        
    }
    
    func valueChanged(sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            
            NSUserDefaults.standardUserDefaults().setObject(space, forKey: schemeKey)
            
            break
        case 1:
            
            NSUserDefaults.standardUserDefaults().setObject(nature, forKey: schemeKey)
            
            break
        default:
            
            NSUserDefaults.standardUserDefaults().setObject(space, forKey: schemeKey)
            
            break
        }
        
    }
    
    func toggleSound() {
        
        if soundOn {
            
            soundOn = false
            soundButton.setTitle("Turn on sound", forState: .Normal)
            NSUserDefaults.standardUserDefaults().setBool(soundOn, forKey: soundKey)
            
        } else {
            
            soundOn = true
            soundButton.setTitle("Turn off sound", forState: .Normal)
            NSUserDefaults.standardUserDefaults().setBool(soundOn, forKey: soundKey)
        }
        
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
