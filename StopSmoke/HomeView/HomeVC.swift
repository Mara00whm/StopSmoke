//
//  ViewController.swift
//  StopSmoke
//
//  Created by Marat on 11.11.2022.
//

import UIKit

class HomeVC: UIViewController {

    var presenter: HomeViewPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        PersistenceController().getAllInfo()
    }


}

extension HomeVC: HomeViewProtocol {
    
}
