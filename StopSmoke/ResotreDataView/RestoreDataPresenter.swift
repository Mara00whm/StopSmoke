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
    init(view: RestoreDataViewProtocol, coreDataManager: CoreDataManagerProtocol)
    func countTotalCigarettes(_ date: Date, cigarettesPerDay: Int)
}

class RestoreDataPresenter: RestoreDataProtocol {
    
    weak var view: RestoreDataViewProtocol?
    let coreDataManager: CoreDataManagerProtocol
    
    required init(view: RestoreDataViewProtocol, coreDataManager: CoreDataManagerProtocol) {
        self.view = view
        self.coreDataManager = coreDataManager
    }
    
    func countTotalCigarettes(_ date: Date, cigarettesPerDay: Int) {
        if let cigarettes = date.days() {
            let totalCigarettes = cigarettes * cigarettesPerDay
            coreDataManager.countCigarettesBefore(started: date, totalCigarettes: totalCigarettes)
        }
    }
}
