//
//  Router.swift
//  StopSmoke
//
//  Created by Marat on 25.11.2022.
//

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? {get set}
    var assemblyBuilder: AssemblerBuilderProtocol? {get set}
}

protocol RouterProtocol: RouterMain {
    func initialVC()
    func mainVC()
    func smokeVC()
    func visualizeVC()
    func healthVC()
    func moneyVC()
    func calendarVC()
    func popToRoot()
}

class Router: RouterProtocol {

    var navigationController: UINavigationController?
    
    var assemblyBuilder: AssemblerBuilderProtocol?

    let userdefaultsManager: UserDefaultsProtocol
    
    let coredataManager: CoreDataManagerProtocol
    
    var mainView: UIViewController?
    
    init(navigationController: UINavigationController,
         assemblyBuilder: AssemblerBuilderProtocol,
         userdefaultsManager: UserDefaultsProtocol,
         coredataManager: CoreDataManagerProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
        self.userdefaultsManager = userdefaultsManager
        self.coredataManager = coredataManager
    }
    
    func restoreVC() {
        if let navigationController = navigationController {
            guard let restoreVC = assemblyBuilder?.createRestoreView(router: self,
                                                                     userdefaultsManager: userdefaultsManager,
                                                                     coredataManager: coredataManager) else { return }
            navigationController.pushViewController(restoreVC, animated: true)
        }
    }

    func initialVC() {
        if userdefaultsManager.readFirstOpenning() == false {
            restoreVC()
        } else {
            mainVC()
        }
    }
    
    func mainVC() {
        if let navigationController = navigationController {
            guard let mainVC = assemblyBuilder?.createMainScreen(router: self,
                                                                 userdefaultsManager: userdefaultsManager,
                                                                 coredataManager: coredataManager) else { return }
            mainView = mainVC
            navigationController.viewControllers = [mainVC]
        }
    }
    
    func smokeVC() {
        if let navigationController = navigationController {
            guard let smokeVC = assemblyBuilder?.createSmokeView(router: self,
                                                                 coredataManager: coredataManager) else { return }
            navigationController.pushViewController(smokeVC, animated: true)
        }
    }
    
    func visualizeVC() {
        guard let visualizeVC = assemblyBuilder?.createVisualizeView(router: self,
                                                                     coredataManager: coredataManager) else { return }
        visualizeVC.modalPresentationStyle = .fullScreen

        if let mainView = mainView {
            
            mainView.present(visualizeVC, animated: true)
        }
    }
    
    func healthVC() {
        guard let healthVC = assemblyBuilder?.createHealthView(router: self,
                                                               coredataManager: coredataManager) else { return }
        healthVC.modalPresentationStyle = .fullScreen
        
        if let mainView = mainView {
            mainView.present(healthVC, animated: true)
        }
    }
    
    func moneyVC() {
        guard let moneyVC = assemblyBuilder?.createMoneyView(router: self,
                                                             coredataManager: coredataManager) else { return }
        moneyVC.modalPresentationStyle = .fullScreen
        if let mainView = mainView {
            mainView.present(moneyVC, animated: true)
        }
    }
    
    func calendarVC() {
        guard let calendarVC = assemblyBuilder?.createCalendarView(router: self,
                                                                   coredataManager: coredataManager) else { return }
        calendarVC.modalPresentationStyle = .fullScreen
        if let mainView = mainView {
            mainView.present(calendarVC, animated: true)
        }
    }
    func popToRoot() {
        if let mainView = mainView {
            mainView.dismiss(animated: true)
        }
    }

}
