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
    func visualizeVC()
    func healthVC()
    func popToRoot()
}

class Router: RouterProtocol {

    var navigationController: UINavigationController?
    
    var assemblyBuilder: AssemblerBuilderProtocol?

    var mainView: UIViewController?
    
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
            mainView = mainVC
            navigationController.viewControllers = [mainVC]
        }
    }
    
    func smokeVC() {
        if let navigationController = navigationController {
            guard let smokeVC = assemblyBuilder?.createSmokeView(router: self) else { return }
            navigationController.pushViewController(smokeVC, animated: true)
        }
    }
    
    func visualizeVC() {
        guard let visualizeVC = assemblyBuilder?.createVisualizeView(router: self) else { return }
        visualizeVC.modalPresentationStyle = .fullScreen

        if let mainView = mainView {
            
            mainView.present(visualizeVC, animated: true)
        }
    }
    
    func healthVC() {
        guard let healthVC = assemblyBuilder?.createHealthView(router: self) else { return }
        healthVC.modalPresentationStyle = .fullScreen
        
        if let mainView = mainView {
            mainView.present(healthVC, animated: true)
        }
    }
    func popToRoot() {
        if let mainView = mainView {
            mainView.dismiss(animated: true)
        }
    }

}
