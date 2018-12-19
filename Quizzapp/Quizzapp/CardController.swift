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
            return (try? Stack.sharedInstance.managedObjectContext.fetch(NSFetchRequest(entityName: "Subject"))) as! Array
        }
    }
    
    static let sharedInstance = CardController ()
    
    func addGradeToSubject(_ subject: Subject, grade: Float) {
        subject.grade = grade as NSNumber?
        save()
    }
    
    func addSubjectWithName(_ name: String) {
        let subject = NSEntityDescription.insertNewObject(forEntityName: "Subject", into: Stack.sharedInstance.managedObjectContext) as! Subject
        subject.name = name
        save()
    }
    
    func addCardToSubject(_ subject: Subject, question: String, answer: String) {
        let card = NSEntityDescription.insertNewObject(forEntityName: "Card", into: Stack.sharedInstance.managedObjectContext) as! Card
        card.subject = subject
        card.question = question
        card.answer = answer
        save()
    }
    
    func removeSubject(_ subject: Subject) {
        subject.managedObjectContext?.delete(subject)
        save()
    }
    
    func addFalseCountToSubject(_ subject: Subject, falseCount: Int) {
        subject.falseCount = falseCount as NSNumber?
        save()
    }
    
    func addTrueCountToSubject(_ subject: Subject, trueCount: Int) {
        subject.trueCount = trueCount as NSNumber?
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
