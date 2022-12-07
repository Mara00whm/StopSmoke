//
//  Builder.swift
//  StopSmoke
//
//  Created by Marat on 11.11.2022.
//

import UIKit

protocol AssemblerBuilderProtocol {
    func createMainScreen(router: RouterProtocol,
                          userdefaultsManager: UserDefaultsProtocol,
                          coredataManager: CoreDataManagerProtocol) -> UIViewController
    
    func createRestoreView(router: RouterProtocol,
                           userdefaultsManager: UserDefaultsProtocol,
                           coredataManager: CoreDataManagerProtocol) -> UIViewController
    
    func createSmokeView(router: RouterProtocol,
                         coredataManager: CoreDataManagerProtocol) -> UIViewController
    func createVisualizeView(router: RouterProtocol,
                             coredataManager: CoreDataManagerProtocol) -> UIViewController
    func createHealthView(router: RouterProtocol,
                          coredataManager: CoreDataManagerProtocol) -> UIViewController
    func createMoneyView(router: RouterProtocol,
                         coredataManager: CoreDataManagerProtocol) -> UIViewController
    func createCalendarView(router: RouterProtocol,
                            coredataManager: CoreDataManagerProtocol) -> UIViewController
}

class ModuleBuilder: AssemblerBuilderProtocol {
 
    func createMainScreen(router: RouterProtocol,
                          userdefaultsManager: UserDefaultsProtocol,
                          coredataManager: CoreDataManagerProtocol) -> UIViewController {
        let view = HomeVC()
        let presenter = HomeViewPresenter(view: view,
                                          coredataManager: coredataManager,
                                          router: router,
                                          userdefaultsManager: userdefaultsManager)
        view.presenter = presenter
        return view
    }

    func createRestoreView(router: RouterProtocol,
                           userdefaultsManager: UserDefaultsProtocol,
                           coredataManager: CoreDataManagerProtocol) -> UIViewController {
        let view = RestoreDataView()
        let presenter = RestoreDataPresenter(view: view,
                                             coreDataManager: coredataManager,
                                             router: router,
                                             userdefaultsManager: userdefaultsManager)
        view.presenter = presenter
        return view
    }
    
    func createSmokeView(router: RouterProtocol,
                         coredataManager: CoreDataManagerProtocol) -> UIViewController {
        let view = SmokeVC()
        let presenter = SmokeViewPresenter(view: view,
                                           coredataManager: coredataManager,
                                           router: router)
        view.presenter = presenter
        return view
    }
    
    func createVisualizeView(router: RouterProtocol,
                             coredataManager: CoreDataManagerProtocol) -> UIViewController {
        let view = VisualizeVC()
        let presenter = VisualizePresenter(view: view,
                                           coredataManager: coredataManager,
                                           router: router)
        view.presenter = presenter
        return view
    }
    
    func createHealthView(router: RouterProtocol,
                          coredataManager: CoreDataManagerProtocol) -> UIViewController {
        let view = HealthView()
        let presenter = HealthPresenter(view: view,
                                        coredataManager: coredataManager,
                                        router: router)
        view.presenter = presenter
        return view
    }
    
    func createMoneyView(router: RouterProtocol,
                         coredataManager: CoreDataManagerProtocol) -> UIViewController {
        let view = MoneyView()
        let presenter = MoneyPresenter(view: view,
                                       coredataManager: coredataManager,
                                       router: router)
        view.presenter = presenter
        return view
    }
    
    func createCalendarView(router: RouterProtocol,
                            coredataManager: CoreDataManagerProtocol) -> UIViewController {
        let view = CalendarView()
        let presenter = CalendarPresenter(view: view,
                                          coredataManager: coredataManager,
                                          router: router)
        view.presenter = presenter
        return view
    }
}
