//
//  Contacts+CoreDataProperties.swift
//  database
//
//  Created by LLF on 2018/4/28.
//  Copyright © 2018 LLF. All rights reserved.
//
//

import Foundation
import CoreData


extension Contacts {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contacts> {
        return NSFetchRequest<Contacts>(entityName: "Contacts")
    }

    @NSManaged public var contact: String?
    @NSManaged public var r_ID: NSDecimalNumber?
    @NSManaged public var contacts: Restaurants?

}
