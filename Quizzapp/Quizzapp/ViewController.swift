//
//  ViewController.swift
//  Quizzapp
//
//  Created by Ethan Hess on 1/17/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var draggableView = DraggableView!()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Action, target: self, action: "pushToDetailView")
        self.navigationItem.rightBarButtonItem = barButtonItem
        
        draggableView = DraggableView(frame: CGRectMake(20, 80, self.view.frame.size.width - 40, 200))
        self.view.addSubview(draggableView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: "flipCell")
        draggableView.addGestureRecognizer(tapGesture)
        
    }
    
    func pushToDetailView() {
        
        
    }
    
    func flipCell() {
        
        UIView.transitionWithView(draggableView, duration: 1, options: UIViewAnimationOptions.TransitionFlipFromRight, animations: { () -> Void in
            
            self.draggableView.flipCell()
            
            }, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

