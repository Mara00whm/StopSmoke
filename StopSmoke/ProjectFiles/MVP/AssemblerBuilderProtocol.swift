//
//  Builder.swift
//  StopSmoke
//
//  Created by Marat on 11.11.2022.
//

import UIKit

protocol AssemblerBuilderProtocol {
    func createMainScreen(router: RouterProtocol) -> UIViewController
    func createRestoreView(router: RouterProtocol, userdefaultsProtocol: UserDefaultsProtocol) -> UIViewController
    func createSmokeView(router: RouterProtocol) -> UIViewController
    func createVisualizeView(router: RouterProtocol) -> UIViewController
    func createHealthView(router: RouterProtocol) -> UIViewController
    func createMoneyView(router: RouterProtocol) -> UIViewController
    func createCalendarView(router: RouterProtocol) -> UIViewController
}

class ModuleBuilder: AssemblerBuilderProtocol {

     let coredataManager: CoreDataManagerProtocol = CoreDataManager()
    
    func createMainScreen(router: RouterProtocol) -> UIViewController {
        let view = HomeVC()
        let presenter = HomeViewPresenter(view: view,
                                          coredataManager: coredataManager,
                                          router: router)
        view.presenter = presenter
        return view
    }

    func createRestoreView(router: RouterProtocol, userdefaultsProtocol: UserDefaultsProtocol) -> UIViewController {
        let view = RestoreDataView()
        let presenter = RestoreDataPresenter(view: view,
                                             coreDataManager: coredataManager,
                                             router: router,
                                             userdefaultsManager: userdefaultsProtocol)
        view.presenter = presenter
        return view
    }
    
    func createSmokeView(router: RouterProtocol) -> UIViewController {
        let view = SmokeVC()
        let presenter = SmokeViewPresenter(view: view,
                                           coredataManager: coredataManager,
                                           router: router)
        view.presenter = presenter
        return view
    }
    
    func createVisualizeView(router: RouterProtocol) -> UIViewController {
        let view = VisualizeVC()
        let presenter = VisualizePresenter(view: view,
                                           coredataManager: coredataManager,
                                           router: router)
        view.presenter = presenter
        return view
    }
    
    func createHealthView(router: RouterProtocol) -> UIViewController {
        let view = HealthView()
        let presenter = HealthPresenter(view: view,
                                        coredataManager: coredataManager,
                                        router: router)
        view.presenter = presenter
        return view
    }
    
    func createMoneyView(router: RouterProtocol) -> UIViewController {
        let view = MoneyView()
        let presenter = MoneyPresenter(view: view,
                                       coredataManager: coredataManager,
                                       router: router)
        view.presenter = presenter
        return view
    }
    
    func createCalendarView(router: RouterProtocol) -> UIViewController {
        let view = CalendarView()
        let presenter = CalendarPresenter(view: view,
                                          coredataManager: coredataManager,
                                          router: router)
        view.presenter = presenter
        return view
    }
}
