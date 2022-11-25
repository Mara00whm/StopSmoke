//
//  SmokeViewPresenter.swift
//  StopSmoke
//
//  Created by Marat on 25.11.2022.
//

import UIKit

protocol SmokeViewProtocol: AnyObject {
    func reloadTable()
}

protocol SmokeViewPresenterProtocol {
    init(view: SmokeViewProtocol, coredataManager: CoreDataManagerProtocol, router: RouterProtocol)
    func smoke()
    var todaySessions: [DayInfo] {get}
}

class SmokeViewPresenter: SmokeViewPresenterProtocol {
    
    var router: RouterProtocol?
    weak var view: SmokeViewProtocol?
    let coredataManager: CoreDataManagerProtocol

    var todaySessions: [DayInfo] = [] {
        didSet {
            view?.reloadTable()
        }
    }

    required init(view: SmokeViewProtocol, coredataManager: CoreDataManagerProtocol, router: RouterProtocol) {
        self.router = router
        self.view = view
        self.coredataManager = coredataManager
    }

    func smoke() {
        coredataManager.smoke()
        //Update data after smoking
        self.getTodaySessions()
    }
    
    func getTodaySessions() {
        todaySessions = coredataManager.getInfoForToday()
    }
}
