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
    func getNumberOfCigarettes() -> Int64?
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
    
    //MARK: - View funcs
    func createNewSmokeSession() {
        let smoke = DayInfo(context: viewContext)
        smoke.smokeDate = Date()
        let fetchRequest: NSFetchRequest<Day> = Day.fetchRequest()
        do {
            let obj = try viewContext.fetch(fetchRequest)
            if let currentDay = obj.last {
                currentDay.addToDayInfo(smoke)
                currentDay.totalCigarettes += 1
                saveContext()
            }
        } catch {
            //TODO: - add catch
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
            //TODO: - add catch
        }
    }
    
    func countCigarettesBefore(started: Date, totalCigarettes: Int) {
        let periodLabel = convertDateToString(started) + " - " + convertDateToString(Date())
        let period = Day(context: viewContext)
        period.day = periodLabel
        period.totalCigarettes = Int64(totalCigarettes)
        saveContext()
    }
    
    func getDateOfLastCigaret() -> Date? {
        let fetchRequest: NSFetchRequest<Day> = Day.fetchRequest()

        do {
            let obj = try viewContext.fetch(fetchRequest)
            return obj.last?.dayInfoUnwrappedArray.last?.smokeDate
        } catch {
            return nil
        }

    }

    func getCountCigarettToday() -> Int64? {
        let fetchRequest: NSFetchRequest<Day> = Day.fetchRequest()
        do {
            let obj = try viewContext.fetch(fetchRequest)
            return obj.last?.day == convertDateToString(Date()) ? obj.last?.totalCigarettes : 0
        } catch {
            return 0
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
            if let day = obj.last {
                return day.dayInfoUnwrappedArray.reversed()
            }
            return []
        } catch {
            return []
        }
    }
    
    func getNumberOfCigarettes() -> Int64? {
        let fetchRequest: NSFetchRequest<Day> = Day.fetchRequest()
        var temp: Int64 = 0
        do {
            let obj = try viewContext.fetch(fetchRequest)
            
            for i in obj {
                temp += i.totalCigarettes
            }
            return temp
        } catch {
            return nil
        }
    }
    //MARK: - Private funcs
    private func createNewDay() {
        let day = Day(context: viewContext)
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
    
}

