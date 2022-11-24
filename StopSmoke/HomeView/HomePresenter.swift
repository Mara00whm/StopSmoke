//
//  HomePresenter.swift
//  StopSmoke
//
//  Created by Marat on 11.11.2022.
//

import Foundation

protocol HomeViewProtocol: AnyObject {
    func setTimeFromLastCigaret(time: TimeInterval)
    func setTotalCigaretts(total: Int64)
    func reloadTable()
}

protocol HomeViewPresenterProtocol {
    init(view: HomeViewProtocol, coredataManager: CoreDataManagerProtocol, router: RouterProtocol)
    var allTimeTableInfo: [Day] {get}
    func getTimeFromLastCigaret()
    func goToSmokeVC()
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
    
    required init(view: HomeViewProtocol,
                  coredataManager: CoreDataManagerProtocol,
                  router: RouterProtocol) {
        self.view = view
        self.coredataManager = coredataManager
        self.router = router

        self.getTimeFromLastCigaret()
        self.getTotalTodayCigaretts()
        self.getInfoForAllTime()
    }
    
    func goToSmokeVC() {
        router?.restoreVC()
    }
    // MARK: - refactor later
    func getTimeFromLastCigaret() {
        if let date = coredataManager.getDateOfLastCigaret() {
            view?.setTimeFromLastCigaret(time: Date() - date)
        }
    }
    
    func getTotalTodayCigaretts() {
        let counter = coredataManager.getCountCigarettToday()
        view?.setTotalCigaretts(total: counter ?? 0)
    }
    
    func getInfoForAllTime() {
        allTimeTableInfo = coredataManager.getInfoForAllTime() ?? []
    }
    
}
