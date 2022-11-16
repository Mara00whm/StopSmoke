//
//  Day+CoreDataProperties.swift
//  StopSmoke
//
//  Created by Marat on 14.11.2022.
//
//

import Foundation
import CoreData


extension Day {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Day> {
        return NSFetchRequest<Day>(entityName: "Day")
    }

    @NSManaged public var day: String?
    @NSManaged public var dayInfo: NSSet?
    
    var unwrappedDayValue: String {
        day ?? "Unknown day"
    }
    
    var dayInfoArray: [DayInfo] {
        let daySet = dayInfo as? Set<DayInfo> ?? []
        
        return daySet.sorted {
            $0.unwrappedName < $1.unwrappedName
            //$0.smokeDate! < $1.smokeDate!
        }
    }

}

// MARK: Generated accessors for dayInfo
extension Day {

    @objc(addDayInfoObject:)
    @NSManaged public func addToDayInfo(_ value: DayInfo)

    @objc(removeDayInfoObject:)
    @NSManaged public func removeFromDayInfo(_ value: DayInfo)

    @objc(addDayInfo:)
    @NSManaged public func addToDayInfo(_ values: NSSet)

    @objc(removeDayInfo:)
    @NSManaged public func removeFromDayInfo(_ values: NSSet)

}

extension Day : Identifiable {

}
