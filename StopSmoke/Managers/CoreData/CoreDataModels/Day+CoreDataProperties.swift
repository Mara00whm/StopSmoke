//
//  Day+CoreDataProperties.swift
//  StopSmoke
//
//  Created by Marat on 21.11.2022.
//
//

import Foundation
import CoreData


extension Day {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Day> {
        return NSFetchRequest<Day>(entityName: "Day")
    }

    @NSManaged public var day: String?
    @NSManaged public var totalCigarettes: Int64
    @NSManaged public var dayInfo: NSSet?
    
    var dayInfoUnwrappedArray: [DayInfo] {
        let dayInfoSet = dayInfo as? Set<DayInfo> ?? []
        
        return dayInfoSet.sorted {
            $0.unwrappedDate < $1.unwrappedDate
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
