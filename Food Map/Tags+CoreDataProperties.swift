//
//  Tags+CoreDataProperties.swift
//  database
//
//  Created by LLF on 2018/4/28.
//  Copyright © 2018 LLF. All rights reserved.
//
//

import Foundation
import CoreData


extension Tags {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tags> {
        return NSFetchRequest<Tags>(entityName: "Tags")
    }

    @NSManaged public var r_ID: NSDecimalNumber?
    @NSManaged public var tag: String?
    @NSManaged public var tags: Restaurants?

}
