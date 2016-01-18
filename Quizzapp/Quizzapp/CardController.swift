//
//  CardController.swift
//  Quizzapp
//
//  Created by Ethan Hess on 1/17/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

import UIKit
import CoreData

class CardController: NSObject {
    
    var subjects: [Subject] {
        
        get {
            return (try? Stack.sharedInstance.managedObjectContext.executeFetchRequest(NSFetchRequest(entityName: "Subject"))) as! Array
        }
    }
    
    static let sharedInstance = CardController ()
    
    func addSubjectWithName(name: String) {
        
        let subject = NSEntityDescription.insertNewObjectForEntityForName("Subject", inManagedObjectContext: Stack.sharedInstance.managedObjectContext) as! Subject
        
        subject.name = name
        save()
    }
    
    func addCardToSubject(subject: Subject, questiion: String, answer: String) {
        
        let card = NSEntityDescription.insertNewObjectForEntityForName("Card", inManagedObjectContext: Stack.sharedInstance.managedObjectContext) as! Card
        
        card.subject = subject
        card.question = questiion
        card.answer = answer
        save()
    }
    
    //Remove methods here
    
    func save() {
        
        do {
            
            try Stack.sharedInstance.managedObjectContext.save()
        }
        
        catch _ {
            
            //catch error here
        }
    }

}
