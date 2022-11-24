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
    func restoreVC()
    func initialVC()
    func smokeVC()
    func popToRoot()
}

class Router: RouterProtocol {

    var navigationController: UINavigationController?
    
    var assemblyBuilder: AssemblerBuilderProtocol?

    init(navigationController: UINavigationController, assemblyBuilder: AssemblerBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func restoreVC() {
        if let navigationController = navigationController {
            guard let restoreVC = assemblyBuilder?.createRestoreView(router: self) else { return }
            navigationController.pushViewController(restoreVC, animated: true)
        }
    }

    func initialVC() {
        if let navigationController = navigationController {
            guard let mainVC = assemblyBuilder?.createMainScreen(router: self) else { return }
            navigationController.viewControllers = [mainVC]
        }
    }
    
    func smokeVC() {
        
    }
    
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        }
    }

}
