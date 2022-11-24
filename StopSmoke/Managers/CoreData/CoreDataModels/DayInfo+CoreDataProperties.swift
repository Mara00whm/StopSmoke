//
//  DayInfo+CoreDataProperties.swift
//  StopSmoke
//
//  Created by Marat on 21.11.2022.
//
//

import Foundation
import CoreData


extension DayInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DayInfo> {
        return NSFetchRequest<DayInfo>(entityName: "DayInfo")
    }

    @NSManaged public var smokeDate: Date?
    @NSManaged public var day: Day?
    
    var unwrappedDate: Date {
        smokeDate ?? Date()
    }

}

extension DayInfo : Identifiable {

}
