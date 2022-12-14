//
//  VisualizeVC.swift
//  StopSmoke
//
//  Created by Marat on 27.11.2022.
//

import UIKit

class VisualizeVC: UIViewController {
    
    var presenter: VisualizePresenterProtocol!
    
    //MARK: - VIEWS
    
    private let closeButton: UIButton = {
       let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setImage(UIImage.closeViewImage, for: .normal)
        view.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        view.tintColor = .viewBackgroundColor
        return view
    }()
    
    private let headerTitle: UILabel = {
       let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .headerFont
        view.text = ViewStringConstants.visualize
        view.textColor = .viewBackgroundColor
        return view
    }()
    
    private let totalCigarettesView: NumberOfCigarettesView = {
        let view = NumberOfCigarettesView(title: ViewStringConstants.numOfCigarettes)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setValues("-")
        view.clipsToBounds = true
        view.layer.cornerRadius = ViewSizeConstants.defaultCornerRadius
        return view
    }()
    
    private let visualizeTableView: UITableView = {
       let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(VisualizeTVC.self,
                      forCellReuseIdentifier: ViewStringConstants.tableId)
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
        createAnchors()
    }
    
    //MARK: - SETTING FUNCS
    
    private func settings() {
        view.backgroundColor = .appBackgroundColor

        view.addSubview(totalCigarettesView)
        view.addSubview(closeButton)
        view.addSubview(visualizeTableView)
        view.addSubview(headerTitle)
        
        visualizeTableView.dataSource = self
        visualizeTableView.delegate = self
    }
    
    private func createAnchors(){
        let safeArea = view.safeAreaLayoutGuide
        
        headerTitle.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: ViewSizeConstants.topPadding).isActive = true
        headerTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        closeButton.leftAnchor.constraint(equalTo: view.leftAnchor,
                                          constant: ViewSizeConstants.leftPadding).isActive = true
        closeButton.centerYAnchor.constraint(equalTo: headerTitle.centerYAnchor).isActive = true
    
        totalCigarettesView.topAnchor.constraint(equalTo: headerTitle.bottomAnchor,
                                                 constant: ViewSizeConstants.topPadding).isActive = true
        totalCigarettesView.leftAnchor.constraint(equalTo: view.leftAnchor,
                                                  constant: ViewSizeConstants.leftPadding).isActive = true
        totalCigarettesView.rightAnchor.constraint(equalTo: view.rightAnchor,
                                                   constant: ViewSizeConstants.rightPadding).isActive = true
        totalCigarettesView.heightAnchor.constraint(equalToConstant: ViewSizeConstants.numberOfCigarettesHeight).isActive = true

        visualizeTableView.topAnchor.constraint(equalTo: totalCigarettesView.bottomAnchor,
                                                constant: ViewSizeConstants.topPadding).isActive = true
        visualizeTableView.leftAnchor.constraint(equalTo: totalCigarettesView.leftAnchor).isActive = true
        visualizeTableView.rightAnchor.constraint(equalTo: totalCigarettesView.rightAnchor).isActive = true
        visualizeTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: ViewSizeConstants.bottomPadding).isActive = true
    }
    
    @objc private func dismissView() {
        presenter.dismissView()
    }
    
    private enum ViewSizeConstants {
        static let topPadding: CGFloat = 15
        static let leftPadding: CGFloat = 15
        static let rightPadding: CGFloat = -15
        static let bottomPadding: CGFloat = -15
        
        static let numberOfCigarettesHeight: CGFloat = 45
        static let tableRowHeight: CGFloat = 150
        
        static let defaultCornerRadius: CGFloat = 15
    }
    
    private enum ViewStringConstants {
        static let numOfCigarettes: String = "Number of cigarettes: "
        static let tableId: String = "metresOfCigarettesTable"
        static let errorString: String = "Something went wrong. Try to reload"
        static let visualize: String = "Visualize"
    }
}

extension VisualizeVC: VisualizeViewProtocol {
    
    func reloadTable() {
        visualizeTableView.reloadData()
    }

    func setNumberOfCigarettes(_ value: Int64) {
        totalCigarettesView.setValues("\(value)")
    }
    
    func cantGetNumberOfCigarettes() {
        let pop = CustomPopUPVC()
        pop.setInfo(errorDesc: ViewStringConstants.errorString) {
            self.presenter.viewWillAppear()
        }
        view.addSubview(pop)
    }
    
    
}

extension VisualizeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.visualizeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: ViewStringConstants.tableId,
                                                    for: indexPath) as? VisualizeTVC {
            let data = presenter.visualizeData[indexPath.row]
            cell.setInfo(imageName: data.imageName,
                         desc: data.name,
                         value: data.metres,
                         cigarettesMetres: presenter.metresOfCigarettes)
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        ViewSizeConstants.tableRowHeight
    }
    
}
