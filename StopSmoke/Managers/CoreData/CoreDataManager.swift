//
//  CoreDataManager.swift
//  StopSmoke
//
//  Created by Marat on 16.11.2022.
//

import Foundation
import CoreData

protocol PersistenceControllerProtocol {
    func smoke()
}

class PersistenceController: PersistenceControllerProtocol {

    let container: NSPersistentContainer

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
            if let currentDay = obj.last {
                currentDay.addToDayInfo(smoke)
                currentDay.totalCigarettes += 1
                print(currentDay)
                saveContext()
            }
        } catch {
            //MARK: - FIXLATER
            print("erorsdfsdf")
        }
    }
    
    func smoke() {
        let fetchRequest: NSFetchRequest<Day> = Day.fetchRequest()
        do {
            let obj = try viewContext.fetch(fetchRequest)
            
            if let currentDay = obj.last?.day,
            currentDay == convertDateToString(Date() ) {
                createNewSmokeSession()
            } else {
                createNewDay()
            }
        } catch {
            //MARK: - FIXLATER
            print("got some errors")
        }
    }
    
    private func createNewDay() {
        let day = Day(context: viewContext)
         let currentDay = convertDateToString(Date() )
        day.day = currentDay
        day.totalCigarettes = 1
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

