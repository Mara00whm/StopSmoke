//
//  DayInfo+CoreDataProperties.swift
//  StopSmoke
//
//  Created by Marat on 14.11.2022.
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
    
    public var unwrappedName: String {
        DateFormatter().string(from: smokeDate ?? Date() ) ?? "Unknown name"
    }

}

extension DayInfo : Identifiable {

}
