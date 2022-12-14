//
//  HealthPresenter.swift
//  StopSmoke
//
//  Created by Marat on 29.11.2022.
//

import UIKit

protocol HealthViewProtocol: AnyObject {
    func reloadTable()
}

protocol HealthPresenterProtocol {
    init(view: HealthViewProtocol,
         coredataManager: CoreDataManagerProtocol,
         router: RouterProtocol)
    func loadData()
    func closeView()
    
    var timeFromLastCigarette: Double {get}
    var healthData: [HealthModel] {get}
}

class HealthPresenter: HealthPresenterProtocol {
    
    var router: RouterProtocol?
    weak var view: HealthViewProtocol?
    let coredataManager: CoreDataManagerProtocol
    
    var timeFromLastCigarette: Double = 0 {
        didSet {
            view?.reloadTable()
        }
    }
    
    var healthData: [HealthModel] = HealthData.healthData
    
    required init(view: HealthViewProtocol,
                  coredataManager: CoreDataManagerProtocol,
                  router: RouterProtocol){
        self.router = router
        self.view = view
        self.coredataManager = coredataManager
    }
    
    func loadData() {
        if let dateOfLastCigarette = coredataManager.getDateOfLastCigarette() {
            timeFromLastCigarette = (Date() - dateOfLastCigarette)/3600
        }
    }
    
    func closeView() {
        router?.popToRoot()
    }
    
}

