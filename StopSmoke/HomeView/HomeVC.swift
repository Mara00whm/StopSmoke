//
//  ViewController.swift
//  StopSmoke
//
//  Created by Marat on 11.11.2022.
//

import UIKit

class HomeVC: UIViewController {

    var presenter: HomeViewPresenterProtocol!

    //MARK: - VIEWS
    
    private var counter: TimeInterval = 0
    
    private let timeFromLastCigaretteView: InfoUIView = {
        let view = InfoUIView(title: "Time since the last cigarette")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = ViewSizeConstants.headerCornerRadius
        view.setValues(ViewStringConstants.timerDefaultLabel)
        return view
    }()
    
    private let todayCigarettesView: InfoUIView = {
       let view = InfoUIView(title: "Today cigarettes")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = ViewSizeConstants.defaultCornerRadius
        view.setValues(ViewStringConstants.counterDefaultLabel)
        return view
    }()
    
    private let averageCigarettesView: InfoUIView = {
        let view = InfoUIView(title: "Average cigarettes")
         view.translatesAutoresizingMaskIntoConstraints = false
         view.clipsToBounds = true
         view.layer.cornerRadius = ViewSizeConstants.defaultCornerRadius
         view.setValues(ViewStringConstants.counterDefaultLabel)
         return view
    }()
    
    private let allTimeInfoTable: UITableView = {
       let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(AllTimeStatisticTVC.self,
                      forCellReuseIdentifier: ViewStringConstants.tableID)
        return view
    }()

    private let smokeButton: DefaultAppButton = {
       let view = DefaultAppButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Want to smoke")
        view.addTarget(self, action: #selector(openSmokeVC), for: .touchUpInside)
        return view
    }()
    //MARK: - OVERRIDE FUNCS

    override func loadView() {
        super.loadView()
        settings()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appBackgroundColor
        navigationItem.title = "s"
        navigationController?.navigationItem.title = "sd"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createAnchors()
    }
    
    //MARK: - SETTING FUNCS
    
    private func settings() {
        view.addSubview(timeFromLastCigaretteView)
        view.addSubview(todayCigarettesView)
        view.addSubview(averageCigarettesView)
        view.addSubview(allTimeInfoTable)
        view.addSubview(smokeButton)
        
        allTimeInfoTable.dataSource = self
        allTimeInfoTable.delegate = self
    }
    
    private func createAnchors(){
        timeFromLastCigaretteView.topAnchor.constraint(equalTo: view.topAnchor,
                                                      constant: ViewSizeConstants.headerTopPadding).isActive = true
        timeFromLastCigaretteView.leftAnchor.constraint(equalTo: view.leftAnchor,
                                                       constant: ViewSizeConstants.leftPadding).isActive = true
        timeFromLastCigaretteView.rightAnchor.constraint(equalTo: view.rightAnchor,
                                                        constant: ViewSizeConstants.rightPadding).isActive = true
        timeFromLastCigaretteView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/ViewSizeConstants.headerSizeDivider).isActive = true
        
        todayCigarettesView.topAnchor.constraint(equalTo: timeFromLastCigaretteView.bottomAnchor,
                                                 constant: ViewSizeConstants.topPadding).isActive = true
        todayCigarettesView.leftAnchor.constraint(equalTo: timeFromLastCigaretteView.leftAnchor).isActive = true
        todayCigarettesView.rightAnchor.constraint(equalTo: timeFromLastCigaretteView.centerXAnchor,
                                                   constant: ViewSizeConstants.rightPadding).isActive = true
        todayCigarettesView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/ViewSizeConstants.defaultViewDivider).isActive = true
        
        averageCigarettesView.topAnchor.constraint(equalTo: todayCigarettesView.topAnchor).isActive = true
        averageCigarettesView.leftAnchor.constraint(equalTo: timeFromLastCigaretteView.centerXAnchor,
                                                    constant: ViewSizeConstants.leftPadding).isActive = true
        averageCigarettesView.rightAnchor.constraint(equalTo: timeFromLastCigaretteView.rightAnchor).isActive = true
        averageCigarettesView.heightAnchor.constraint(equalTo: todayCigarettesView.heightAnchor).isActive = true
        
        smokeButton.topAnchor.constraint(equalTo: averageCigarettesView.bottomAnchor,
                                         constant: ViewSizeConstants.topPadding).isActive = true
        smokeButton.leftAnchor.constraint(equalTo: timeFromLastCigaretteView.leftAnchor).isActive = true
        smokeButton.rightAnchor.constraint(equalTo: timeFromLastCigaretteView.rightAnchor).isActive = true
        smokeButton.heightAnchor.constraint(equalToConstant: ViewSizeConstants.itemHeight).isActive = true
        
        allTimeInfoTable.topAnchor.constraint(equalTo: smokeButton.bottomAnchor,
                                              constant: ViewSizeConstants.topPadding).isActive = true
        allTimeInfoTable.leftAnchor.constraint(equalTo: timeFromLastCigaretteView.leftAnchor).isActive = true
        allTimeInfoTable.rightAnchor.constraint(equalTo: timeFromLastCigaretteView.rightAnchor).isActive = true
        allTimeInfoTable.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    //MARK: - objc funcs
    @objc private func getTimeFromLastCigaret() {
        let time = counter.timeString()
        counter += 1
        timeFromLastCigaretteView.setValues("\(time)")
    }
    
    @objc private func openSmokeVC() {
        presenter.goToSmokeVC()
    }
    //MARK: - Enum constants

    private enum ViewSizeConstants {
        static let leftPadding: CGFloat = 10
        static let rightPadding: CGFloat = -10
        static let headerTopPadding: CGFloat = 30
        static let topPadding: CGFloat = 15
        
        static let headerSizeDivider: CGFloat = 6
        static let defaultViewDivider: CGFloat = 8
        static let itemHeight: CGFloat = 50
        
        static let headerCornerRadius: CGFloat = 25
        static let defaultCornerRadius: CGFloat = 15
    }
    
    private enum ViewStringConstants {
        static let tableID: String = "allInfoTable"
        static let timerDefaultLabel: String = "-- h : -- m : -- s"
        static let counterDefaultLabel: String = "-"
    }
    
}

extension HomeVC: HomeViewProtocol {
    func setTimeFromLastCigaret(time: TimeInterval) {
        counter = time
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(getTimeFromLastCigaret), userInfo: nil, repeats: true)
    }
    
    func setTotalCigaretts(total: Int64) {
        todayCigarettesView.setValues("\(total)")
    }
    
    func reloadTable() {
        self.allTimeInfoTable.reloadData()
    }
}


extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return presenter.allTimeTableInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ViewStringConstants.tableID,
                                                    for: indexPath) as? AllTimeStatisticTVC {
            let data = presenter.allTimeTableInfo[indexPath.row]
            cell.setInfo(data.day ?? "",
                         countCigarettes: data.totalCigarettes)
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
