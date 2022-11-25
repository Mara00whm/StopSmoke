//
//  CoreDataManager.swift
//  StopSmoke
//
//  Created by Marat on 16.11.2022.
//

import Foundation
import CoreData

protocol CoreDataManagerProtocol {
    func smoke()
    func countCigarettesBefore(started: Date, totalCigarettes: Int)
    func getDateOfLastCigaret() -> Date?
    func getCountCigarettToday() -> Int64?
    func getInfoForAllTime() -> [Day]?
    func getInfoForToday() -> [DayInfo]
}

class CoreDataManager: CoreDataManagerProtocol {

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
    
    //MARK: - TEST LATER
    func smoke() {
        let fetchRequest: NSFetchRequest<Day> = Day.fetchRequest()
        do {
            let obj = try viewContext.fetch(fetchRequest)
            
            if let currentDay = obj.last?.day,
            currentDay == convertDateToString(Date() ) {
                createNewSmokeSession()
            } else {
                createNewDay()
                createNewSmokeSession()
            }
        } catch {
            //MARK: - FIXLATER
            print("got some errors")
        }
    }
    
    func countCigarettesBefore(started: Date, totalCigarettes: Int) {
        let periodLabel = convertDateToString(started) + " - " + convertDateToString(Date())
        
        let period = Day(context: viewContext)
        period.day = periodLabel
        period.totalCigarettes = Int64(totalCigarettes)
        print(period)
        saveContext()
        
    }
    
    func getDateOfLastCigaret() -> Date? {
        let fetchRequest: NSFetchRequest<Day> = Day.fetchRequest()

        do {
            let obj = try viewContext.fetch(fetchRequest)
            print("Fetching")
            return obj.last?.dayInfoUnwrappedArray.last?.smokeDate

        } catch {
            return nil
        }

    }
    
    //MARK: - CHANGE LATER!
    func getCountCigarettToday() -> Int64? {
        let fetchRequest: NSFetchRequest<Day> = Day.fetchRequest()
        print("here")
        do {
            let obj = try viewContext.fetch(fetchRequest)
            print(obj.last?.totalCigarettes)
            return obj.last?.totalCigarettes
            
        } catch {
            print("here")
            return nil
        }
    }

    func getInfoForAllTime() -> [Day]? {
        let fetchRequest: NSFetchRequest<Day> = Day.fetchRequest()
        let df = DateFormatter()
        df.dateFormat = "MMM d, YY"
        df.locale = Locale(identifier: "en_US_POSIX")
        df.timeZone = TimeZone(identifier: "UTC")!
        do {
            let obj = try viewContext.fetch(fetchRequest)
            return obj.sorted {
                df.date(from: $0.day!) ?? Date() > df.date(from: $1.day!) ?? Date()
            }.reversed()
        } catch {
            return nil
        }
    }
    
    func getInfoForToday() -> [DayInfo] {
        let fetchRequest: NSFetchRequest<Day> = Day.fetchRequest()
        do {
            let obj = try viewContext.fetch(fetchRequest)
            //print(obj.last?.dayInfoUnwrappedArray)
            if let day = obj.last {
                return day.dayInfoUnwrappedArray.reversed()
            }
            return []
        } catch {
            return []
        }
    }
    
    private func createNewDay() {
        let day = Day(context: viewContext)
        var date = Date()
        
        let currentDay = convertDateToString(Date() )
        day.day = currentDay
        day.totalCigarettes = 0
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

