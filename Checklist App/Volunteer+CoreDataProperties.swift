//
//  Volunteer+CoreDataProperties.swift
//  Checklist App
//
//  Created by John Slomka on 2019-05-06.
//  Copyright © 2019 Life North Church. All rights reserved.
//
//

import Foundation
import CoreData


extension Volunteer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Volunteer> {
        return NSFetchRequest<Volunteer>(entityName: "Volunteer")
    }

    @NSManaged public var service: String?
    @NSManaged public var position: String?
    @NSManaged public var percentage: Double
    @NSManaged public var name: String?
    @NSManaged public var missedQuestions: NSObject?
    @NSManaged public var date: NSDate?

}
