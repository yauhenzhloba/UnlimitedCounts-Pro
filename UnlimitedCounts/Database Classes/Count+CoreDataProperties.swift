//
//  Count+CoreDataProperties.swift
//  UnlimitedCounts
//
//  Created by EUGENE on 2/7/19.
//  Copyright © 2019 Eugene Zloba. All rights reserved.
//
//

import Foundation
import CoreData


extension Count {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Count> {
        return NSFetchRequest<Count>(entityName: "Count")
    }

    @NSManaged public var count: Int16
    @NSManaged public var date: Double
    @NSManaged public var idTitle: String?

}
