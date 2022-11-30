//
//  HealthVC.swift
//  StopSmoke
//
//  Created by Marat on 29.11.2022.
//

import UIKit

class HealthView: UIViewController {
    
    var presenter: HealthPresenterProtocol!
    
    //MARK: - VIEWS
    
    private var closeButton: UIButton = {
       let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setImage(UIImage.closeViewImage, for: .normal)
        view.tintColor = .white
        view.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        return view
    }()
    
    private var healthLabel: UILabel = {
       var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.boldSystemFont(ofSize: ViewSizeConstants.headerTextSize)
        view.text = ViewStringConstants.health
        view.textColor = .white
        return view
    }()
    
    private var healthStatisticTable: UITableView = {
       let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.estimatedRowHeight = 40
        view.rowHeight = UITableView.automaticDimension
        view.register(HealthStatisticTVC.self,
                      forCellReuseIdentifier: ViewStringConstants.tableID)
        view.backgroundColor = .appBackgroundColor
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createAnchors()
        presenter.loadData()
    }
    
    //MARK: - SETTING FUNCS
    
    private func settings() {
        view.addSubview(healthStatisticTable)
        view.addSubview(healthLabel)
        view.addSubview(closeButton)

        healthStatisticTable.delegate = self
        healthStatisticTable.dataSource = self
    }
    
    private func createAnchors(){
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([

        healthLabel.topAnchor.constraint(equalTo: safeArea.topAnchor,
                                         constant: ViewSizeConstants.safeAreaTopPadding),
        healthLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        
        closeButton.leftAnchor.constraint(equalTo: view.leftAnchor,
                                          constant: ViewSizeConstants.leftPadding),
        closeButton.centerYAnchor.constraint(equalTo: healthLabel.centerYAnchor),
        
        healthStatisticTable.topAnchor.constraint(equalTo: healthLabel.bottomAnchor,
                                                  constant: ViewSizeConstants.topPadding),
        healthStatisticTable.leftAnchor.constraint(equalTo: view.leftAnchor,
                                                   constant: ViewSizeConstants.leftPadding),
        healthStatisticTable.rightAnchor.constraint(equalTo: view.rightAnchor,
                                                    constant: ViewSizeConstants.rightPadding),
        healthStatisticTable.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    //MARK: - Constants
    
    private enum ViewSizeConstants {
        static let safeAreaTopPadding: CGFloat = 5
        
        static let topPadding: CGFloat = 15
        static let leftPadding: CGFloat = 15
        static let rightPadding: CGFloat = -15
        static let botPadding: CGFloat = -15
        
        static let headerTextSize: CGFloat = 30
    }
    
    private enum ViewStringConstants {
        static let tableID: String = "healthTableID"
        
        static let health: String = "Health"
    }
    //MARK: - router func
    
    @objc private func closeView() {
        presenter.closeView()
    }
}

extension HealthView: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        HealthData.healthData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ViewStringConstants.tableID,
                                                    for: indexPath) as? HealthStatisticTVC {
            let data = HealthData.healthData[indexPath.row]
            cell.setInfo(image: data.image,
                         desctiprion: data.desciption,
                         timeNeed: data.hours,
                         timePassed: presenter.timeFromLastCigarette)
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

extension HealthView: HealthViewProtocol {

    func reloadTable() {
        healthStatisticTable.reloadData()
    }

}
