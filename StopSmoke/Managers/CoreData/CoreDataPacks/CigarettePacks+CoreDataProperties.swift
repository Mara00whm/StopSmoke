//
//  CigarettePacks+CoreDataProperties.swift
//  
//
//  Created by Marat on 30.11.2022.
//
//

import Foundation
import CoreData


extension CigarettePacks {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CigarettePacks> {
        return NSFetchRequest<CigarettePacks>(entityName: "CigarettePacks")
    }

    @NSManaged public var day: Date?
    @NSManaged public var price: Double

    
}
