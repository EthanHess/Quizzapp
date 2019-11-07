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
    
    var scrollView : UIScrollView!
    
    var creditsArray = ["Sound URLs, courtesy of Freesound.org", "Wrong Sound: https://www.freesound.org/people/Bertrof/sounds/131657/", "Right Sound: https://www.freesound.org/people/rhodesmas/sounds/320777/"]
    
    var theBackground : UIImageView = {
        let theIV = UIImageView()
        theIV.image = UIImage(named: "galaxyWideBlue")
        return theIV
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpScrollView()
        backgroundImage()
        
        self.view.backgroundColor = UIColor(red: 24/255, green: 66/255, blue: 52/255, alpha: 1.0)
        
        let tableFrame = CGRect(x: 10, y: 0, width: view.frame.size.width - 20, height: view.frame.size.height / 2)

        self.tableView = UITableView(frame: tableFrame, style: .grouped)
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.layer.cornerRadius = 5
        self.tableView.layer.borderColor = UIColor.white.cgColor
        self.tableView.clipsToBounds = true
        self.tableView.separatorStyle = .none
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "creditCell")
        self.scrollView.addSubview(self.tableView)
        
        self.segControl = UISegmentedControl(items: ["Space Scheme", "Nature Scheme"])
        self.segControl.frame = CGRect(x: 50, y: view.frame.size.height / 2 + 50, width: view.frame.size.width - 100, height: 50)
        self.segControl.tintColor = UIColor.white
        self.segControl.backgroundColor = UIColor(red: 72/255, green: 87/255, blue: 196/255, alpha: 1.0)
        
        self.segControl.addTarget(self, action: #selector(CreditsViewController.valueChanged(_:)), for: .valueChanged)
        self.scrollView.addSubview(segControl)
        
        let buttonFrame = CGRect(x: 50, y: self.view.frame.size.height / 2 + 120, width: view.frame.size.width - 100, height: 50)
        
        self.soundButton = UIButton(frame: buttonFrame)
        self.soundButton.setTitle("Turn off sound", for: UIControlState())
        self.soundButton.backgroundColor = UIColor(red: 72/255, green: 87/255, blue: 196/255, alpha: 1.0)
        self.soundButton.setTitleColor(UIColor.white, for: UIControlState())
        self.soundButton.addTarget(self, action: #selector(CreditsViewController.toggleSound), for: .touchUpInside)
        self.soundButton.layer.cornerRadius = 5
        self.soundButton.layer.borderColor = UIColor.white.cgColor
        self.soundButton.layer.borderWidth = 1
        self.scrollView.addSubview(soundButton)
    }
    
    fileprivate func backgroundImage() {
        theBackground.frame = self.view.bounds
        self.view.insertSubview(theBackground, at: 0)
    }
    
    func setUpScrollView() {
        scrollView = UIScrollView(frame: self.view.bounds)
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height + 250)
        
        self.view.sendSubview(toBack: scrollView)
        self.view.addSubview(scrollView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return creditsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "creditCell")
        
        cell?.textLabel?.text = creditsArray[indexPath.row]
        //cell?.backgroundColor = UIColor.darkGray
        cell?.backgroundColor = Colors().niceBlue
        cell?.textLabel?.textColor = UIColor.white
        cell?.textLabel?.font = UIFont(name: cFont, size: 12)
        cell?.textLabel?.numberOfLines = 0
    
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    @objc func valueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            UserDefaults.standard.set(space, forKey: schemeKey)
            AppFunctions().setNavBarAppearanceForVC(self, backgroundColor: Colors().navBackgroundColor, textColor: UIColor.white)
            break
        case 1:
            UserDefaults.standard.set(nature, forKey: schemeKey)
            AppFunctions().setNavBarAppearanceForVC(self, backgroundColor: Colors().brownColor, textColor: UIColor.white)
            break
        default:
            UserDefaults.standard.set(space, forKey: schemeKey)
            AppFunctions().setNavBarAppearanceForVC(self, backgroundColor: Colors().navBackgroundColor, textColor: UIColor.white)
            break
        }
    }
    
    @objc func toggleSound() {
        if soundOn {
            soundOn = false
            soundButton.setTitle("Turn on sound", for: UIControlState())
            UserDefaults.standard.set(soundOn, forKey: soundKey)
        } else {
            soundOn = true
            soundButton.setTitle("Turn off sound", for: UIControlState())
            UserDefaults.standard.set(soundOn, forKey: soundKey)
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
