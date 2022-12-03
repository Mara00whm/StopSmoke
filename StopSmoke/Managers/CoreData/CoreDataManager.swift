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
    func getDateOfLastCigarette() -> Date?
    func getCountCigarettToday() -> Int64?
    func getInfoForAllTime() -> [Day]?
    func getInfoForToday() -> [DayInfo]
    func getNumberOfCigarettes() -> Int64?
    func createNewDay()
    func setWellbeing(wellbeing: String)
    func addNewCigarettePack(price: Double)
    func getCigarettePacks() -> [CigarettePacks]
    func getSpentMoney() -> Double
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
    
    private func createNewSmokeSession() {
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
    
    //MARK: - View funcs
    func smoke() {
        let fetchRequest: NSFetchRequest<Day> = Day.fetchRequest()
        do {
            let obj = try viewContext.fetch(fetchRequest)
            
            if let currentDay = obj.last?.day,
               currentDay == Date().convertDateToString() {
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
        let periodLabel = started.convertDateToString() + " - " + Date().convertDateToString()
        let period = Day(context: viewContext)
        period.day = periodLabel
        period.totalCigarettes = Int64(totalCigarettes)
        saveContext()
    }
    
    func getDateOfLastCigarette() -> Date? {
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
            return obj.last?.day == Date().convertDateToString() ? obj.last?.totalCigarettes : 0
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
    
    func addNewCigarettePack(price: Double) {
        let pack = CigarettePacks(context: viewContext)
        pack.day = Date()
        pack.price = price
        saveContext()
    }
    
    func getCigarettePacks() -> [CigarettePacks] {
        let fetchRequest: NSFetchRequest<CigarettePacks> = CigarettePacks.fetchRequest()
        
        do {
            let obj = try viewContext.fetch(fetchRequest)
            
            return obj
        } catch {
            return []
        }
    }
    
    func getSpentMoney() -> Double {
        let fetchRequest: NSFetchRequest<CigarettePacks> = CigarettePacks.fetchRequest()
        var count: Double = 0
        do {
            let obj = try viewContext.fetch(fetchRequest)
            
            for i in obj {
                count += i.price
            }
            return count
        } catch {
            return 0
        }
    }
    
    // If user doesn't smoke today -> create new day with note else just rewrite last. User can add wellbeing only for today. Previous dates only read
    func setWellbeing(wellbeing: String) {
        let fetchRequest: NSFetchRequest<Day> = Day.fetchRequest()
        
        do {
            let obj = try viewContext.fetch(fetchRequest)
            
            if obj.last?.day == Date().convertDateToString() {
                obj.last?.wellbeing = wellbeing
                saveContext()
            } else {
                createNewDayWithWellbeing(wellBeing: wellbeing)
            }

        } catch {
            createNewDayWithWellbeing(wellBeing: wellbeing)
        }
    }

     func createNewDay() {
        let day = Day(context: viewContext)
        let currentDay = Date().convertDateToString()
        day.day = currentDay
        day.totalCigarettes = 0
        day.wellbeing = ""
        saveContext()
    }

    //MARK: - Private funcs

    private func createNewDayWithWellbeing(wellBeing: String) {
        let day = Day(context: viewContext)
        let dayString = Date().convertDateToString()
        day.day = dayString
        day.wellbeing = wellBeing
        day.totalCigarettes = 0
        saveContext()
    }
    
}
