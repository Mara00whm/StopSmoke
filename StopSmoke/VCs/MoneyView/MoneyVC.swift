//
//  MoneyView.swift
//  StopSmoke
//
//  Created by Marat on 30.11.2022.
//

import UIKit

class MoneyView: UIViewController {
    
    var presenter: MoneyPresenterProtocol!
    
    //MARK: - VIEWS
    
    private let closeView: UIButton = {
       let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setImage(UIImage.closeViewImage, for: .normal)
        view.tintColor = .viewBackgroundColor
        view.addTarget(self, action: #selector(popToRoot), for: .touchUpInside)
        return view
    }()
    
    private let headerLabel: UILabel = {
       let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = .white
        view.font = .headerFont
        view.text = ViewStringConstants.moneyHeaderLabel
        return view
    }()
    
    private let priceLabel: UILabel = {
       let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = .viewBackgroundColor
        view.text = ViewStringConstants.priceLabel
        return view
    }()
    
    private let packPriceTextField: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 15
        view.keyboardType = .decimalPad
        view.textColor = .appBackgroundColor
        view.backgroundColor = .viewBackgroundColor
        view.textAlignment = .center
        return view
    }()
    
    private let saveButton: SavePackPriceButton = {
       let view = SavePackPriceButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle(ViewStringConstants.saveLabel)
        view.addTarget(self, action: #selector(addNewPackPrice), for: .touchUpInside)
        return view
    }()
    
    private let cigarettePacksTable: UITableView = {
       let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .appBackgroundColor
        view.register(CigarettePackCell.self,
                      forCellReuseIdentifier: ViewStringConstants.tableID)
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
        presenter.loadData()
        createAnchors()
        setupTextFields()
    }
    
    //MARK: - SETTING FUNCS
    
    private func settings() {
        view.addSubview(headerLabel)
        view.addSubview(closeView)
        view.addSubview(priceLabel)
        view.addSubview(packPriceTextField)
        view.addSubview(saveButton)
        view.addSubview(cigarettePacksTable)
        
        cigarettePacksTable.delegate = self
        cigarettePacksTable.dataSource = self
    }
    
    private func createAnchors(){
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: ViewSizeConstants.littleTopPaddong),
        headerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        
        closeView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: ViewSizeConstants.leftPadding),
        closeView.centerYAnchor.constraint(equalTo: headerLabel.centerYAnchor),
        
        priceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        priceLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: ViewSizeConstants.topPadding),
        
        packPriceTextField.leftAnchor.constraint(equalTo: closeView.leftAnchor),
        packPriceTextField.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: ViewSizeConstants.topPadding),
        packPriceTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: ViewSizeConstants.rightPadding),
        packPriceTextField.heightAnchor.constraint(equalToConstant: ViewSizeConstants.tfHeight),
        
        saveButton.leftAnchor.constraint(equalTo: packPriceTextField.leftAnchor),
            saveButton.topAnchor.constraint(equalTo: packPriceTextField.bottomAnchor, constant: ViewSizeConstants.littleTopPaddong),
        saveButton.rightAnchor.constraint(equalTo: packPriceTextField.rightAnchor),
        saveButton.heightAnchor.constraint(equalTo: packPriceTextField.heightAnchor),
        
        cigarettePacksTable.leftAnchor.constraint(equalTo: saveButton.leftAnchor),
        cigarettePacksTable.rightAnchor.constraint(equalTo: saveButton.rightAnchor),
        cigarettePacksTable.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: ViewSizeConstants.topPadding),
            cigarettePacksTable.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: ViewSizeConstants.littleBotPadding),
        ])
    }
    
    @objc private func addNewPackPrice() {
        presenter.addNewPackOfCigarettes(packPriceTextField.text ?? "")
        packPriceTextField.text = ""
        doneButtonTapped()
    }
    
    private func setupTextFields() {
        let toolbar = UIToolbar()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                        target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done,
                                         target: self, action: #selector(doneButtonTapped))
        
        toolbar.setItems([flexSpace, doneButton], animated: true)
        toolbar.sizeToFit()
        
        packPriceTextField.inputAccessoryView = toolbar
    }
    
    @objc private func doneButtonTapped() {
        view.endEditing(true)
    }

    @objc private func popToRoot() {
        presenter.popToRoot()
    }
    //MARK: - Enum constants
    
    private enum ViewStringConstants {
        static let tableID: String = "packsPriceID"
        
        static let priceLabel: String = "Price of cigarette pack($): "
        static let saveLabel: String = "Save"
        static let moneyHeaderLabel: String = "Money"
    }
    
    private enum ViewSizeConstants {
        static let headerLabel: CGFloat = 30
        static let topPadding: CGFloat = 15
        static let leftPadding: CGFloat = 15
        static let rightPadding: CGFloat = -15
        static let botPadding: CGFloat = -15
        static let tfHeight: CGFloat = 40
        
        static let littleTopPaddong: CGFloat = 5
        static let littleBotPadding: CGFloat = -5
    }
}

extension MoneyView: MoneyViewProtocol {
    
    func incorrectEnteredPrice() {
        let alert = UIAlertController(title: "Error", message: "Entered price is incorrect", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    func reloadTable() {
        cigarettePacksTable.reloadData()
    }

}

extension MoneyView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.cigarettePacks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ViewStringConstants.tableID,
                                                    for: indexPath) as? CigarettePackCell {
            let data = presenter.cigarettePacks[indexPath.row]
            cell.setInfo(data.day ?? Date() ,
                         countCigarettes: data.price)
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
