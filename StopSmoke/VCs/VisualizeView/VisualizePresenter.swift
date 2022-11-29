//
//  VisualizePresenter.swift
//  StopSmoke
//
//  Created by Marat on 27.11.2022.
//

import Foundation
import UIKit

protocol VisualizeViewProtocol: AnyObject {
    func setNumberOfCigarettes(_ value: Int64)
    func cantGetNumberOfCigarettes()
    func reloadTable()
}

protocol VisualizePresenterProtocol {
    init(view: VisualizeViewProtocol, coredataManager: CoreDataManagerProtocol, router: RouterProtocol)
    func viewWillAppear()
    func dismissView()
    var metresOfCigarettes: Double {get}
}

class VisualizePresenter: VisualizePresenterProtocol {
    
    var router: RouterProtocol?
    weak var view: VisualizeViewProtocol?
    let coredataManager: CoreDataManagerProtocol

    var metresOfCigarettes: Double = 0 {
        didSet {
            view?.reloadTable()
        }
    }
    
    required init(view: VisualizeViewProtocol, coredataManager: CoreDataManagerProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
        self.coredataManager = coredataManager
    }
    
    func viewWillAppear() {
        getTotalCigarettes()
    }
    
    func dismissView() {
        router?.popToRoot()
    }
    //MARK: - Private funcs
    private func getTotalCigarettes() {
        if let temp = coredataManager.getNumberOfCigarettes() {
            getMetresOfCigarettes(temp)
            view?.setNumberOfCigarettes(temp)
        } else {
            view?.cantGetNumberOfCigarettes()
        }
    }

    private func getMetresOfCigarettes(_ count: Int64) {
        self.metresOfCigarettes = Double((count * 7) / 100)
    }
}
