//
//  HomePresenter.swift
//  StopSmoke
//
//  Created by Marat on 11.11.2022.
//

import Foundation

protocol HomeViewProtocol: AnyObject {
    
}

protocol HomeViewPresenterProtocol {
    init(view: HomeViewProtocol)
}


class HomeViewPresenter: HomeViewPresenterProtocol {

    weak var view: HomeViewProtocol?

    required init(view: HomeViewProtocol) {
        self.view = view
    }
    
    
}
