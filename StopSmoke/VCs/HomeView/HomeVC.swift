//
//  ViewController.swift
//  StopSmoke
//
//  Created by Marat on 11.11.2022.
//

import UIKit
import JJFloatingActionButton

class HomeVC: UIViewController {

    var presenter: HomeViewPresenterProtocol!
    
    private var counter: TimeInterval = 0
    
    var timer: Timer?

    //MARK: - VIEWS
    private let actionFloatingButton: JJFloatingActionButton = {
       let view = JJFloatingActionButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let visualizeFloatingButton: JJFloatingActionButton = {
       let view = JJFloatingActionButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let timeFromLastCigaretteView: InfoUIView = {
        let view = InfoUIView(title: "Time since the last cigarette")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = ViewSizeConstants.headerCornerRadius
        view.setValues(ViewStringConstants.timerDefaultLabel)
        return view
    }()
    
    private let todayCigarettesView: InfoUIView = {
        let view = InfoUIView(title: ViewStringConstants.todayCigarettes)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = ViewSizeConstants.defaultCornerRadius
        view.setValues(ViewStringConstants.counterDefaultLabel)
        return view
    }()
    
    private let averageCigarettesView: InfoUIView = {
        let view = InfoUIView(title: ViewStringConstants.moneySpent)
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
        view.backgroundColor = .appBackgroundColor
        return view
    }()

    private let smokeButton: DefaultAppButton = {
       let view = DefaultAppButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle(ViewStringConstants.wantSmoke)
        view.addTarget(self, action: #selector(openSmokeVC), for: .touchUpInside)
        return view
    }()
    //MARK: - OVERRIDE FUNCS

    override func loadView() {
        super.loadView()
        settings()
        setUpFAB()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appBackgroundColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createAnchors()
        timer?.invalidate()
        presenter.loadData()
    }
    
    //MARK: - SETTING FUNCS
    
    private func settings() {
        view.addSubview(timeFromLastCigaretteView)
        view.addSubview(todayCigarettesView)
        view.addSubview(averageCigarettesView)
        view.addSubview(allTimeInfoTable)
        view.addSubview(smokeButton)
        view.addSubview(actionFloatingButton)
        view.addSubview(visualizeFloatingButton)
    
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
        
        actionFloatingButton.rightAnchor.constraint(equalTo: view.rightAnchor,
                                                    constant: ViewSizeConstants.rightPadding).isActive = true

        actionFloatingButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                     constant: ViewSizeConstants.botPadding).isActive = true
        
        visualizeFloatingButton.leftAnchor.constraint(equalTo: view.leftAnchor,
                                                      constant: ViewSizeConstants.leftPadding).isActive = true
        visualizeFloatingButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                        constant: ViewSizeConstants.botPadding).isActive = true
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
        static let botPadding: CGFloat = -15
        
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
        
        static let visualize: String = "Visualize"
        static let health: String = "Health"
        static let cigaretteLimit: String = "Cigarette limit"
        static let wellbeingCalendar: String = "Well-being calendar"
        static let moneySpent: String = "Money spent($)"
        static let wantSmoke: String = "Want to smoke"
        static let todayCigarettes: String = "Today cigarettes"
        
        static let save: String = "Save"
        static let cancel: String = "Cancel"
        static let limitHeader: String = "Limit"
        static let limitMessage: String = "Enter your cigarettes limit"
    }
    
}

extension HomeVC: HomeViewProtocol {

    func setMoneySpent(_ money: Double) {
        averageCigarettesView.setValues(money.roundToPlace())
    }
    
    func setTimeFromLastCigaret(time: TimeInterval) {
        counter = time
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(getTimeFromLastCigaret),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    func setTotalCigaretts(total: String) {
        todayCigarettesView.setValues(total)
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

//MARK: - Floating action button setting

extension HomeVC {
    private func setUpFAB() {
        // Action button setup
        actionFloatingButton.handleSingleActionDirectly = false
        actionFloatingButton.buttonDiameter = ViewSizeConstants.itemHeight
        actionFloatingButton.buttonColor = .acceptButton
        actionFloatingButton.buttonImage = .editImage
    
        actionFloatingButton.buttonAnimationConfiguration = .transition(toImage: .buttonCloseImage)
        actionFloatingButton.itemAnimationConfiguration.itemLayout = .circular()
        
        actionFloatingButton.addItem(title: ViewStringConstants.cigaretteLimit,
                                     image: .settingsImage) { _ in
            let alertController: UIAlertController = UIAlertController(title: ViewStringConstants.limitHeader,
                                                                       message: ViewStringConstants.limitMessage,
                                                                       preferredStyle: .alert)
            
            //Save button
            let saveAction: UIAlertAction = UIAlertAction(title: ViewStringConstants.save,
                                                          style: .default) { action -> Void in
                self.presenter.saveToUserDefaults(alertController.textFields?.first?.text)
            }
            
            let cancelAction: UIAlertAction = UIAlertAction(title: ViewStringConstants.cancel, style: .destructive)
            
            alertController.addAction(cancelAction)
            alertController.addAction(saveAction)
            alertController.addTextField { tf in
                tf.textAlignment = .center
                tf.keyboardType = .numberPad
            }
            self.present(alertController, animated: true)
        }

        actionFloatingButton.addItem(title: ViewStringConstants.moneySpent,
                                     image: .moneyImage) { _ in
            self.presenter.goToMoneyVC()
        }

        actionFloatingButton.addItem(title: ViewStringConstants.wellbeingCalendar,
                                     image: .calendarImage) { _ in
            self.presenter.goToCalendarVC()
        }
        
        //Visualize button setup
        visualizeFloatingButton.handleSingleActionDirectly = false
        visualizeFloatingButton.buttonDiameter = ViewSizeConstants.itemHeight
        visualizeFloatingButton.buttonColor = .acceptButton
        visualizeFloatingButton.buttonImage = .chartImage
        visualizeFloatingButton.buttonAnimationConfiguration = .transition(toImage: .buttonCloseImage)
        visualizeFloatingButton.itemAnimationConfiguration = .slideIn()
        visualizeFloatingButton.configureDefaultItem { item in
            item.titlePosition = .right
        }
        
        visualizeFloatingButton.addItem(title: ViewStringConstants.visualize,
                                     image: .visualizeImage) { _ in
            self.presenter.goToVisualizeVC()
        }
        
        visualizeFloatingButton.addItem(title: ViewStringConstants.health,
                                     image: .heartImage) { _ in
            self.presenter.goToHealthVC()
        }
        
    }
}
