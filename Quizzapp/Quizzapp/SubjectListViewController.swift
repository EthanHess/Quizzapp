//
//  SubjectListViewController.swift
//  Quizzapp
//
//  Created by Ethan Hess on 1/18/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class SubjectListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate, UITextFieldDelegate {
    
    var tableView : UITableView!
    var subjectToAdd : Subject?
    var addCardView : AddView!
    var addInstructionsImageView : UIImageView!
    var addViewFrame : CGRect?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        registerForNotifications()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //maybe change to custom popout view later
        
        let addButton = UIBarButtonItem(title: "Add Class", style: UIBarButtonItemStyle.plain, target: self, action: #selector(SubjectListViewController.addSubject))
        //self.navigationItem.rightBarButtonItem = addButton
        
        let scoreButton = UIBarButtonItem(title: "See Scores", style: UIBarButtonItemStyle.plain, target: self, action: #selector(SubjectListViewController.presentScores))
        
        self.navigationItem.rightBarButtonItems = [addButton, scoreButton]

        self.tableView = UITableView(frame: CGRect(x: 50, y: 80, width: self.view.frame.size.width - 100, height: self.view.frame.size.height), style: UITableViewStyle.grouped)
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        
        //make view bigger for iphone 4 (480) and 5 (568)
        
        if screenHeight == 480 {
            addViewFrame = CGRect(x: self.view.frame.size.width, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height / 2 + 150)
        } else if screenHeight == 568 {
            addViewFrame = CGRect(x: self.view.frame.size.width, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height / 2 + 100)
        } else {
            addViewFrame = CGRect(x: self.view.frame.size.width, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height / 2)
        }
        
        self.addCardView = AddView(frame: addViewFrame!)
    
        self.addCardView.layer.cornerRadius = 10
        self.addCardView.layer.borderColor = Colors().cardTextColor.cgColor
        self.addCardView.layer.borderWidth = 2
        self.addCardView.layer.masksToBounds = true
        self.addCardView.textView.delegate = self
        self.addCardView.textField.delegate = self
        
        self.addCardView.addCardButton.addTarget(self, action: #selector(SubjectListViewController.addCard), for: UIControlEvents.touchUpInside)
        self.addCardView.clearButton.addTarget(self, action: #selector(SubjectListViewController.clearFields), for: .touchUpInside)
        self.addCardView.dismissButton.addTarget(self, action: #selector(SubjectListViewController.dismissAddView), for: .touchUpInside)
        
        self.view.addSubview(self.addCardView)
        
        //add instructions imageView
        addInstructionsImageView = UIImageView(frame: CGRect(x: 80, y: 200, width: self.view.frame.size.width - 160, height: self.view.frame.size.height - 300))
        addInstructionsImageView.image = UIImage(named: "QAddBackground")
        
        if self.noSubjects() {
            addInstructionsImageView.isHidden = false
        } else {
            addInstructionsImageView.isHidden = true
        }
        
        view.insertSubview(addInstructionsImageView, at: 1)
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
        if noSubjects() {
            displayAlert("No Subjects", message: "Please add some classes and try again!")
        } else {
            let scoreList = ScoreListViewController()
            self.present(scoreList, animated: true, completion: nil)
        }
    }
    
    func scheme() -> String? {
        return UserDefaults.standard.object(forKey: schemeKey) as? String
    }

    func standardBackground() {
        let imageView = UIImageView(frame: view.bounds)
        imageView.image = UIImage(named: "listBackground")
        view.insertSubview(imageView, at: 0)
    }
    
    func customBackground() {
        let imageView = UIImageView(frame: view.bounds)
        imageView.image = UIImage(named: "NatureListBG")
        view.insertSubview(imageView, at: 0)
    }
    
    func noSubjects() -> Bool {
        return CardController.sharedInstance.subjects.count == 0
    }
    
    //remember to dealloc
    
    func registerForNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(SubjectListViewController.refreshTable), name: NSNotification.Name(rawValue: "refresh"), object: nil)
    }
    
    deinit { //could do in view did disappear?
        print("Notification observation being removed")
        NotificationCenter.default.removeObserver(self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : TableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        
        let subject = CardController.sharedInstance.subjects[indexPath.row] as Subject!
        
        let right = Int((subject?.trueCount!)!)
        let wrong = Int((subject?.falseCount!)!)
        
        //clear out image views to prevent overlap
        
        cell.bgImageRight.image = nil
        cell.bgImageWrong.image = nil
        cell.gradeImage.image = nil
        
        cell.setGradePicture(right, wrong: wrong)
        cell.setRightAndWrongCount(right, wrong: wrong)
        
        cell.titleLabel.text = subject?.name!
        
        cell.scoreLabel.text = NSString(format: "right: %i, wrong: %i", Int((subject?.trueCount!)!), Int((subject?.falseCount!)!)) as String
        
        if (subject?.cards?.count == 1) {
            cell.cardCountLabel.text = NSString(format: "%d Card", (subject?.cards?.count)!) as String
        } else {
            cell.cardCountLabel.text = NSString(format: "%d Cards", (subject?.cards?.count)!) as String
        }
        
        cell.layer.cornerRadius = 10
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 2
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CardController.sharedInstance.subjects.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260
    }
    
    func addSubject() {
        let alertController = UIAlertController(title: "Add subject", message: "For quiz stack", preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addTextField { (textField) -> Void in
            textField.placeholder = "Subject title"
        }
        
        let alertAction = UIAlertAction(title: "Save", style: UIAlertActionStyle.default) { (action) -> Void in
            
            let nameField = alertController.textFields![0]
            if nameField.text != "" {
                CardController.sharedInstance.addSubjectWithName(nameField.text!)
                self.addInstructionsImageView.isHidden = true
                self.refreshTable()
            } else {
                self.displayAlert("Please add a title", message: "")
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (action) -> Void in
            self.dismiss(animated: true, completion: nil)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(alertAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //make sure if card count == 0 that an alert pops up telling them to add at least one card
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let subject = CardController.sharedInstance.subjects[indexPath.row] as Subject!
        self.subjectToAdd = subject
        
        let alertController = UIAlertController(title: "Options", message: "Add card or start quiz", preferredStyle: UIAlertControllerStyle.alert)
        let alertAction = UIAlertAction(title: "Add Card", style: UIAlertActionStyle.default) { (action) -> Void in
            
            self.popOutAddCardViewWithSubject(subject!)
        }
        
        let viewAction = UIAlertAction(title: "Start Quiz!", style: UIAlertActionStyle.default) { (action) -> Void in
            
            let subjectDetailVC = SubjectDetailViewController()
            subjectDetailVC.subject = subject
            self.navigationController?.pushViewController(subjectDetailVC, animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (action) -> Void in
            
            //cancels self
        }
        
        alertController.addAction(alertAction)
        alertController.addAction(viewAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)

    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if (editingStyle == UITableViewCellEditingStyle.delete) {
    CardController.sharedInstance.removeSubject(CardController.sharedInstance.subjects[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
        
    }
    
    func popOutAddCardViewWithSubject(_ subject: Subject) {
        
        //can't interact with cells when add view is popped out
        self.tableView.isUserInteractionEnabled = false
        
        if subject.cards?.count > 15 {
            self.displayAlert("There are already 15 cards in this class", message: "Feel free to start another")
        } else {
        
        //pop out add card view etc.
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.addCardView.center = CGPoint(x: self.view.center.x, y: self.addCardView.center.y)
            self.tableView.center = CGPoint(x: self.view.center.x, y: self.view.center.y + self.view.frame.size.height - self.addCardView.frame.size.height)
            self.addCardView.titleLabel.text = subject.name
            self.navigationController?.isNavigationBarHidden = true
            self.tableView.alpha = 0.5
        }) 
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
        
        self.tableView.isUserInteractionEnabled = true
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.addCardView.center = CGPoint(x: self.view.center.x + self.view.frame.size.width, y: self.addCardView.center.y)
            self.tableView.center = CGPoint(x: self.view.center.x, y: self.view.center.y + 80)
            self.navigationController?.isNavigationBarHidden = false
            self.tableView.alpha = 1
        }) 
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        addCard()
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    //weird text view delegate
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
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
    
    func displayAlert(_ title: String, message: String) {
        let alertCon = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let okayAction = UIAlertAction(title: "Okay!", style: .cancel, handler: nil)
        alertCon.addAction(okayAction)
        present(alertCon, animated: true, completion: nil)
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
