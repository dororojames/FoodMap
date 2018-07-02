//
//  Restaurants+CoreDataClass.swift
//  database
//
//  Created by LLF on 2018/4/17.
//  Copyright © 2018 LLF. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Restaurants)
public class Restaurants: NSManagedObject {
    var firstTag: String?
    var price_low: Int? = 0
    var price_high: Int? = 0
}
