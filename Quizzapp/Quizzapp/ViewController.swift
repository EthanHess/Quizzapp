//
//  ViewController.swift
//  Quizzapp
//
//  Created by Ethan Hess on 1/17/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "pushToDetailView")
        self.navigationItem.rightBarButtonItem = barButtonItem
        
        //establish colors
        
        let colorOne = CGFloat(55)
        let colorTwo = CGFloat(140)
        let colorThree = CGFloat(245)
        
        self.view.backgroundColor = UIColor(red: colorOne / 255.0, green: colorTwo / 255.0, blue: colorThree / 255.0, alpha: 1.0)
    }
    
    func pushToDetailView() {
        
        let subjectView = SubjectListViewController()
        
        self.navigationController?.pushViewController(subjectView, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

