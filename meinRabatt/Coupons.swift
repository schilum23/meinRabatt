//
//  Coupons.swift
//  meinRabatt
//
//  Created by Oliver Rosner on 25.08.14.
//  Copyright (c) 2014 Schilum23. All rights reserved.
//

import Foundation
import CoreData

class Coupons: NSManagedObject {

    @NSManaged var text: String
    @NSManaged var link: String
    @NSManaged var shop: Shops

}
