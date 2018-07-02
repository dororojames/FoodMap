//
//  Opentime+CoreDataProperties.swift
//  database
//
//  Created by LLF on 2018/4/28.
//  Copyright © 2018 LLF. All rights reserved.
//
//

import Foundation
import CoreData


extension Opentime {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Opentime> {
        return NSFetchRequest<Opentime>(entityName: "Opentime")
    }

    @NSManaged public var day: String?
    @NSManaged public var r_ID: NSDecimalNumber?
    @NSManaged public var timeslot: String?
    @NSManaged public var opentime: Restaurants?

}
