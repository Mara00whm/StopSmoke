//
//  Builder.swift
//  StopSmoke
//
//  Created by Marat on 11.11.2022.
//

import UIKit

protocol Builder {
    static func createModule() -> UIViewController
    static func createRestoreView() -> UIViewController
}

class ModuleBuilder: Builder {

    static let coredataManager: CoreDataManagerProtocol = CoreDataManager()
    
    static func createModule() -> UIViewController {
        let view = HomeVC()
        let presenter = HomeViewPresenter(view: view, coredataManager: coredataManager)
        view.presenter = presenter
        return view
    }

    static func createRestoreView() -> UIViewController {
        let view = RestoreDataView()
        let presenter = RestoreDataPresenter(view: view, coreDataManager: coredataManager)
        view.presenter = presenter
        return view
    }
}
