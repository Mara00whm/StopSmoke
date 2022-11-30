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
    func viewWillAppear()
    func closeView()
    
    var timeFromLastCigarette: Double {get}
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
    
    required init(view: HealthViewProtocol,
                  coredataManager: CoreDataManagerProtocol,
                  router: RouterProtocol){
        self.router = router
        self.view = view
        self.coredataManager = coredataManager
    }
    
    func viewWillAppear() {
        if let dateOfLastCigarette = coredataManager.getDateOfLastCigarette() {
            timeFromLastCigarette = (Date() - dateOfLastCigarette)/3600
        }
    }
    
    func closeView() {
        router?.popToRoot()
    }
    
}

