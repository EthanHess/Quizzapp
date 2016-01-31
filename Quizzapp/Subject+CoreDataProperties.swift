//
//  Subject+CoreDataProperties.swift
//  Quizzapp
//
//  Created by Ethan Hess on 1/30/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Subject {

    @NSManaged var name: String?
    @NSManaged var falseCount: NSNumber?
    @NSManaged var trueCount: NSNumber?
    @NSManaged var cards: NSOrderedSet?

}
