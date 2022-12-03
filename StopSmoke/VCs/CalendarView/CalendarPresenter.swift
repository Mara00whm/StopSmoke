//
//  CalendarPresenter.swift
//  StopSmoke
//
//  Created by Marat on 02.12.2022.
//

import Foundation

protocol CalendarViewProtocol: AnyObject {
    func reloadData()
    func setWellbeing(date: Date, _ string: String?)
}

protocol CalendarPresenterProtocol {
    init(view: CalendarViewProtocol, coredataManager: CoreDataManagerProtocol, router: RouterProtocol)
    func loadView()
    func saveWellbeing(_ wellbeing: String)
    func getWellbeingFor(_ day: Date)
    var smokedDays: [String] {get}
    func popToRoot()
}

class CalendarPresenter: CalendarPresenterProtocol {
    
    var router: RouterProtocol?
    weak var view: CalendarViewProtocol?
    let coredataManager: CoreDataManagerProtocol
    
    private var days: [Day] = []
    
    var smokedDays: [String] = [] {
        didSet {
            view?.reloadData()
        }
    }

    required init(view: CalendarViewProtocol, coredataManager: CoreDataManagerProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
        self.coredataManager = coredataManager
    }
    
    func saveWellbeing(_ wellbeing: String) {
        coredataManager.setWellbeing(wellbeing: wellbeing)
    }
    
    func loadView() {
        getDaysInfo()
        getWellbeingsDays()
        getWellbeingFor(Date())
    }
    
    func getWellbeingFor(_ day: Date){
        for element in days {
            if element.day == day.convertDateToString() {
                view?.setWellbeing(date: day, element.wellbeing)
                return
            }
        }
        view?.setWellbeing(date: day, "None")
    }
    
    func popToRoot() {
        router?.popToRoot()
    }
    
    //MARK: - private funcs
    private func getDaysInfo() {
        if let days = coredataManager.getInfoForAllTime() {
            self.days = days
        }
    }

    //Add days to another 
    private func getWellbeingsDays() {
        var temp: [String] = []
        for day in days {
            if let desc = day.day {
                temp.append(desc)
            }
        }
        smokedDays = temp
   }

}
