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
    
    func removeSubject(subject: Subject) {
        
        subject.managedObjectContext?.deleteObject(subject)
        save()
    }
    
    func addFalseCountToSubject(subject: Subject, falseCount: Int) {
        
        subject.falseCount = falseCount
        save()
        
    }
    
    func addTrueCountToSubject(subject: Subject, trueCount: Int) {
        
        subject.trueCount = trueCount
        save()
    }
    
    func save() {
        
        do {
            
            try Stack.sharedInstance.managedObjectContext.save()
        }
        
        catch _ {
            
            //catch error here
        }
    }

}
