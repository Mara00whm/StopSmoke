//
//  CoreDataManager.swift
//  StopSmoke
//
//  Created by Marat on 16.11.2022.
//

import Foundation
import CoreData

protocol PersistenceControllerProtocol {

}

class PersistenceController: PersistenceControllerProtocol {

    let container: NSPersistentContainer
    var dayInfo: Day?

    // Convenience
    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }

    init() {
        container = NSPersistentContainer(name: "StopSmokeModel")
    
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }

    func saveContext() {
        let context = container.viewContext

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func createNewSmokeSession() {
        let smoke = DayInfo(context: viewContext)
        smoke.smokeDate = Date()
        let fetchRequest: NSFetchRequest<Day> = Day.fetchRequest()
        do {
            let obj = try viewContext.fetch(fetchRequest)
            if let currentDate = obj.last {
                currentDate.addToDayInfo(smoke)
                saveContext()
            }
        } catch {
            print("erorsdfsdf")
        }
        print(dayInfo?.dayInfoArray)
    }
    
    func getAllInfo() {
        let fetchRequest: NSFetchRequest<Day> = Day.fetchRequest()
        do {
            let obj = try viewContext.fetch(fetchRequest)

            for object in obj {
                print(object.unwrappedDayValue)
            }
            
            if let currentDay = obj.last?.day,
            currentDay == convertDateToString(Date() ) {
                dayInfo = obj.last
                createNewSmokeSession()
            } else {
                createNewDay()
            }
        } catch {
            print("got some errors")
        }
    }
    
    func getDayInfo() {
        let fetchRequest: NSFetchRequest<DayInfo> = DayInfo.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let obj = try viewContext.fetch(fetchRequest)
            print(obj)
        } catch {
            print("got errors on details")
        }
    }
    
    private func createNewDay() {
        let day = Day(context: viewContext)
         let currentDay = convertDateToString(Date() )
        day.day = currentDay
        saveContext()
    }

    private func convertDateToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, YY"
        return dateFormatter.string(from: date)
    }
    
    
    func deleteAllData() {
        let fetchRequest: NSFetchRequest<Day> = Day.fetchRequest()
        do {
            let obj = try viewContext.fetch(fetchRequest)
            
            for i in obj {
                try viewContext.delete(i)
            }
            try viewContext.save()
        } catch {
            print("Asd")
        }
    }
}

