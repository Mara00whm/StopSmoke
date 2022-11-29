//
//  SmokeViewVC.swift
//  StopSmoke
//
//  Created by Marat on 25.11.2022.
//

import UIKit

class SmokeVC: UIViewController {

    var presenter: SmokeViewPresenter!
    //MARK: - VIEWS
    
    private let relaxButton: DefaultAppButton = {
        let view = DefaultAppButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle(ViewStringConstants.relax)
        return view
    }()
    
    private let smokeButton: SmokeButton = {
       let view = SmokeButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle(ViewStringConstants.smoke)
        view.addTarget(self, action: #selector(smoke), for: .touchUpInside)
        return view
    }()
    
    private let todaySessionLabel: UILabel = {
       let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .viewBackgroundColor
        view.textAlignment = .center
        view.text = ViewStringConstants.today
        view.font = UIFont.boldSystemFont(ofSize: 25)
        return view
    }()
    private let todaySessionsInfoTable: UITableView = {
       let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(TodayInfoTVC.self,
                      forCellReuseIdentifier: ViewStringConstants.tableViewID)
        return view
    }()
    //MARK: - OVERRIDE FUNCS
    
    override func loadView() {
        super.loadView()
        settings()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createAnchors()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        presenter.getTodaySessions()
    }
    
    //MARK: - SETTING FUNCS
    
    private func settings() {
        view.backgroundColor = .appBackgroundColor
        view.addSubview(relaxButton)
        view.addSubview(smokeButton)
        view.addSubview(todaySessionsInfoTable)
        view.addSubview(todaySessionLabel)
        
        todaySessionsInfoTable.delegate = self
        todaySessionsInfoTable.dataSource = self
    }
    
    private func createAnchors(){
        let safeArea = view.safeAreaLayoutGuide
        smokeButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: ViewSizeConstants.topPadding).isActive = true
        smokeButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: ViewSizeConstants.leftPadding).isActive = true
        smokeButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: ViewSizeConstants.rightPadding).isActive = true
        smokeButton.heightAnchor.constraint(equalToConstant: ViewSizeConstants.buttonHeight).isActive = true
        
        relaxButton.topAnchor.constraint(equalTo: smokeButton.bottomAnchor, constant: ViewSizeConstants.topPadding).isActive = true
        relaxButton.leftAnchor.constraint(equalTo: smokeButton.leftAnchor).isActive = true
        relaxButton.rightAnchor.constraint(equalTo: smokeButton.rightAnchor).isActive = true
        relaxButton.heightAnchor.constraint(equalToConstant: ViewSizeConstants.buttonHeight).isActive = true
    
        
        todaySessionLabel.leftAnchor.constraint(equalTo: smokeButton.leftAnchor).isActive = true
        todaySessionLabel.rightAnchor.constraint(equalTo: smokeButton.rightAnchor).isActive = true
        todaySessionLabel.topAnchor.constraint(equalTo: relaxButton.bottomAnchor, constant: ViewSizeConstants.topPadding).isActive = true
        
        todaySessionsInfoTable.leftAnchor.constraint(equalTo: smokeButton.leftAnchor).isActive = true
        todaySessionsInfoTable.rightAnchor.constraint(equalTo: smokeButton.rightAnchor).isActive = true
        todaySessionsInfoTable.topAnchor.constraint(equalTo: todaySessionLabel.bottomAnchor, constant: ViewSizeConstants.topPadding).isActive = true
        todaySessionsInfoTable.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    @objc func smoke() {
        presenter.smoke()
    }
    
    //MARK: - ENUMS
    
    private enum ViewSizeConstants {
        static let buttonHeight: CGFloat = 50
        static let topPadding: CGFloat = 20
        static let leftPadding: CGFloat = 15
        static let rightPadding: CGFloat = -15
    }

    private enum ViewStringConstants {
        static let tableViewID: String = "todaySessionsTableView"
        static let smoke: String = "Smoke"
        static let relax: String = "Relax"
        static let today: String = "Today sessions"
    }
}

extension SmokeVC: SmokeViewProtocol {
    func reloadTable() {
        todaySessionsInfoTable.reloadData()
    }
}

extension SmokeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.todaySessions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ViewStringConstants.tableViewID,
                                                    for: indexPath) as? TodayInfoTVC {
            let data = presenter.todaySessions[indexPath.row]
            cell.setInfo(data.smokeDate!, numberOfCigarette: indexPath.row.reverse(presenter.todaySessions.count))
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        let verticalPadding: CGFloat = 8

        let maskLayer = CALayer()
        maskLayer.cornerRadius = 10
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 0, dy: verticalPadding/2)
        cell.layer.mask = maskLayer
    }
}
