//
//  Shops.swift
//  meinRabatt
//
//  Created by Oliver Rosner on 25.08.14.
//  Copyright (c) 2014 Schilum23. All rights reserved.
//

import Foundation
import CoreData

class Shops: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var image: NSData
    @NSManaged var imageLink: String
    @NSManaged var coupon: NSSet

}
