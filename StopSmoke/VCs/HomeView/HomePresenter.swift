//
//  HomePresenter.swift
//  StopSmoke
//
//  Created by Marat on 11.11.2022.
//

import Foundation

protocol HomeViewProtocol: AnyObject {
    func setTimeFromLastCigaret(time: TimeInterval)
    func setTotalCigaretts(total: String)
    func setMoneySpent(_ money: Double)
    func reloadTable()
}

protocol HomeViewPresenterProtocol {
    init(view: HomeViewProtocol,
         coredataManager: CoreDataManagerProtocol,
         router: RouterProtocol,
         userdefaultsManager: UserDefaultsProtocol)

    func saveToUserDefaults(_ value: String?)
    var allTimeTableInfo: [Day] {get}
    func goToSmokeVC()
    func goToVisualizeVC()
    func goToHealthVC()
    func goToMoneyVC()
    func goToCalendarVC()
    func loadData()
}


class HomeViewPresenter: HomeViewPresenterProtocol {

    var allTimeTableInfo: [Day] = [] {
        didSet {
            view?.reloadTable()
        }
    }
    
    var router: RouterProtocol?
    weak var view: HomeViewProtocol?
    let coredataManager: CoreDataManagerProtocol
    let userdefaultsManager: UserDefaultsProtocol

    required init(view: HomeViewProtocol,
                  coredataManager: CoreDataManagerProtocol,
                  router: RouterProtocol,
                  userdefaultsManager: UserDefaultsProtocol) {
        self.view = view
        self.coredataManager = coredataManager
        self.router = router
        self.userdefaultsManager = userdefaultsManager

        self.getTimeFromLastCigaret()
        self.getTotalTodayCigaretts()
        self.getInfoForAllTime()
    }
    
    func loadData() {
        self.getTimeFromLastCigaret()
        self.getTotalTodayCigaretts()
        self.getInfoForAllTime()
        self.getSpentMoney()
    }
    // MARK: - refactor later
    func getTimeFromLastCigaret() {
        if let date = coredataManager.getDateOfLastCigarette() {
            view?.setTimeFromLastCigaret(time: Date() - date)
        }
    }
    
    func getTotalTodayCigaretts() {
        let counter = coredataManager.getCountCigarettToday()
        
        if let limit = userdefaultsManager.readCigaretteLimit() {
            view?.setTotalCigaretts(total: "\(counter ?? 0) / \(limit)")
            return
        }
        view?.setTotalCigaretts(total: "\(counter ?? 0)")
    }
    
    func getInfoForAllTime() {
        allTimeTableInfo = coredataManager.getInfoForAllTime() ?? []
    }
    
    func getSpentMoney() {
        let money = coredataManager.getSpentMoney()
        view?.setMoneySpent(money)
    }
    
    func saveToUserDefaults(_ value: String?) {
        if let intValue = Int(value ?? "") {
            userdefaultsManager.storeCigaretteLimit(intValue)
            getTotalTodayCigaretts()
        }
    }
    
    // MARK: - Router funcs
    func goToSmokeVC() {
        router?.smokeVC()
    }
    
    func goToVisualizeVC() {
        router?.visualizeVC()
    }
    
    func goToHealthVC() {
        router?.healthVC()
    }
    
    func goToMoneyVC() {
        router?.moneyVC()
    }
    
    func goToCalendarVC() {
        router?.calendarVC()
    }

}
