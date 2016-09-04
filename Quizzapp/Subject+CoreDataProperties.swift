//
//  Subject+CoreDataProperties.swift
//  Quizzapp
//
//  Created by Ethan Hess on 9/3/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Subject {

    @NSManaged var falseCount: NSNumber?
    @NSManaged var name: String?
    @NSManaged var trueCount: NSNumber?
    @NSManaged var grade: NSNumber?
    @NSManaged var cards: NSOrderedSet?

}
