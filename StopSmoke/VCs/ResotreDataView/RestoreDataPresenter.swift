//
//  RestoreDataPresenter.swift
//  StopSmoke
//
//  Created by Marat on 21.11.2022.
//

import Foundation

protocol RestoreDataViewProtocol: AnyObject {
    
}

protocol RestoreDataProtocol {
    init(view: RestoreDataViewProtocol,
         coreDataManager: CoreDataManagerProtocol,
         router: RouterProtocol,
         userdefaultsManager: UserDefaultsProtocol)
    func countTotalCigarettes(_ date: Date, cigarettesPerDay: Int)
    func goToMainView()
}

class RestoreDataPresenter: RestoreDataProtocol {
    
    weak var view: RestoreDataViewProtocol?
    let coreDataManager: CoreDataManagerProtocol
    let userdefaultsManager: UserDefaultsProtocol
    var router: RouterProtocol?
    
    required init(view: RestoreDataViewProtocol, coreDataManager: CoreDataManagerProtocol, router: RouterProtocol, userdefaultsManager: UserDefaultsProtocol) {
        self.view = view
        self.coreDataManager = coreDataManager
        self.router = router
        self.userdefaultsManager = userdefaultsManager
    }
    
    func countTotalCigarettes(_ date: Date, cigarettesPerDay: Int) {
        if let cigarettes = date.days() {
            let totalCigarettes = cigarettes * cigarettesPerDay
            coreDataManager.countCigarettesBefore(started: date, totalCigarettes: totalCigarettes)
        }
    }
    
    func goToMainView() {
        userdefaultsManager.storeFirstOpenning(true)
        coreDataManager.createNewDay()
        router?.mainVC()
    }
}
