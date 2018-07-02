//
//  Restaurants+CoreDataProperties.swift
//  database
//
//  Created by LLF on 2018/4/28.
//  Copyright © 2018 LLF. All rights reserved.
//
//

import Foundation
import CoreData


extension Restaurants {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Restaurants> {
        return NSFetchRequest<Restaurants>(entityName: "Restaurants")
    }

    @NSManaged public var latitude: String?
    @NSManaged public var longitude: String?
    @NSManaged public var name: String?
    @NSManaged public var price_range: String?
    @NSManaged public var r_ID: NSDecimalNumber?
    @NSManaged public var address: String?
    @NSManaged public var contact: NSSet?
    @NSManaged public var opentime: NSSet?
    @NSManaged public var tag: NSSet?
}

// MARK: Generated accessors for contact
extension Restaurants {

    @objc(addContactObject:)
    @NSManaged public func addToContact(_ value: Contacts)

    @objc(removeContactObject:)
    @NSManaged public func removeFromContact(_ value: Contacts)

    @objc(addContact:)
    @NSManaged public func addToContact(_ values: NSSet)

    @objc(removeContact:)
    @NSManaged public func removeFromContact(_ values: NSSet)

}

// MARK: Generated accessors for opentime
extension Restaurants {

    @objc(addOpentimeObject:)
    @NSManaged public func addToOpentime(_ value: Opentime)

    @objc(removeOpentimeObject:)
    @NSManaged public func removeFromOpentime(_ value: Opentime)

    @objc(addOpentime:)
    @NSManaged public func addToOpentime(_ values: NSSet)

    @objc(removeOpentime:)
    @NSManaged public func removeFromOpentime(_ values: NSSet)

}

// MARK: Generated accessors for tag
extension Restaurants {

    @objc(addTagObject:)
    @NSManaged public func addToTag(_ value: Tags)

    @objc(removeTagObject:)
    @NSManaged public func removeFromTag(_ value: Tags)

    @objc(addTag:)
    @NSManaged public func addToTag(_ values: NSSet)

    @objc(removeTag:)
    @NSManaged public func removeFromTag(_ values: NSSet)

}
