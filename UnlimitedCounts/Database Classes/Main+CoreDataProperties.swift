//
//  Main+CoreDataProperties.swift
//  UnlimitedCounts
//
//  Created by EUGENE on 2/7/19.
//  Copyright © 2019 Eugene Zloba. All rights reserved.
//
//

import Foundation
import CoreData


extension Main {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Main> {
        return NSFetchRequest<Main>(entityName: "Main")
    }

    @NSManaged public var dateTitle: Double
    @NSManaged public var idTitle: String?
    @NSManaged public var nameTitle: String?

}
