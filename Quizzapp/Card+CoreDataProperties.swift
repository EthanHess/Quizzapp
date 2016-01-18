//
//  Card+CoreDataProperties.swift
//  Quizzapp
//
//  Created by Ethan Hess on 1/18/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Card {

    @NSManaged var question: String?
    @NSManaged var answer: String?
    @NSManaged var subject: Subject?

}
