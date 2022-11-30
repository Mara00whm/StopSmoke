//
//  MoneyPresenter.swift
//  StopSmoke
//
//  Created by Marat on 30.11.2022.
//

import UIKit

protocol MoneyViewProtocol: AnyObject {
    func reloadTable()
    func incorrectEnteredPrice()
}

protocol MoneyPresenterProtocol {
    init(view: MoneyViewProtocol, coredataManager: CoreDataManagerProtocol, router: RouterProtocol)
    func addNewPackOfCigarettes(_ priceLabel: String)
    
    var cigarettePacks: [CigarettePacks] { get }
    
    func popToRoot()
    func loadData()
}

class MoneyPresenter: MoneyPresenterProtocol {
    
    var router: RouterProtocol?
    weak var view: MoneyViewProtocol?
    let coredataManager: CoreDataManagerProtocol

    var cigarettePacks: [CigarettePacks] = [] {
        didSet {
            view?.reloadTable()
        }
    }

    required init(view: MoneyViewProtocol, coredataManager: CoreDataManagerProtocol, router: RouterProtocol) {
        self.router = router
        self.view = view
        self.coredataManager = coredataManager
    }
    
    func addNewPackOfCigarettes(_ priceLabel: String) {
        if checkPrice(priceLabel) {
            if let price = Double(priceLabel.replacingOccurrences(of: ",", with: ".")) {
                coredataManager.addNewCigarettePack(price: price)
            }
            loadData()
        } else {
            view?.incorrectEnteredPrice()
        }
    }
    
    func loadData() {
        getCigarettePacks()
    }
    
    func popToRoot() {
        router?.popToRoot()
    }
    
    private func getCigarettePacks() {
        cigarettePacks = coredataManager.getCigarettePacks().reversed()
    }
    
    private func checkPrice(_ price: String) -> Bool {
        var count = 0
        
        for i in price {
            if i == "," {
                count += 1
            }
        }
       return count >= 2 ? false : true
    }
}
