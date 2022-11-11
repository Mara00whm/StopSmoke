//
//  Builder.swift
//  StopSmoke
//
//  Created by Marat on 11.11.2022.
//

import UIKit

protocol Builder {
    static func createModule() -> UIViewController

}

class ModuleBuilder: Builder {

    static func createModule() -> UIViewController {
        let view = HomeVC()
        let presenter = HomeViewPresenter(view: view)
        view.presenter = presenter
        return view
    }

}
