//
//  RestoreDataView.swift
//  StopSmoke
//
//  Created by Marat on 21.11.2022.
//

import UIKit

class RestoreDataView: UIViewController {
    
    private static let localizedName: String = "RestoreDataViewLocalized"
    
    var presenter: RestoreDataProtocol!
    //MARK: - VIEWS
    
    private let skipButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle(ViewTextConstants.neverSmokedButton.rawValue.localize(from: localizedName), for: .normal)
        view.setTitleColor(UIColor.lightGray, for: .normal)
        view.addTarget(self, action: #selector(goToMainVC), for: .touchUpInside)
        return view
    }()
    
    private let firstSmokeLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = ViewTextConstants.chooseDayLabel.rawValue.localize(from: localizedName)
        view.textColor = .viewBackgroundColor
        return view
    }()
    
    private let firstSmokeDate: UIDatePicker = {
        let view = UIDatePicker()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.preferredDatePickerStyle = .compact
        view.datePickerMode = .date
        view.maximumDate = Date()
        return view
    }()
    
    private let averageCigarettesLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = ViewTextConstants.averageCigarettes.rawValue.localize(from: localizedName)
        view.textColor = .viewBackgroundColor
        return view
    }()
    
    private let averageCigarettesTextField: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.keyboardType = .numberPad
        view.layer.cornerRadius = ViewSizeConstants.cornerRadius
        view.backgroundColor = .viewBackgroundColor
        view.textAlignment = .center
        view.textColor = .appBackgroundColor
        return view
    }()
    
    private let acceptButton: DefaultAppButton = {
        let view = DefaultAppButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle(ViewTextConstants.doneButton.rawValue.localize(from: localizedName))
        view.addTarget(self, action: #selector(countCigarettes), for: .touchUpInside)
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
        createAnhors()
    }
    
    //MARK: - VIEW SETTING FUNCS
    
    private func createAnhors() {
        skipButton.topAnchor.constraint(equalTo: view.topAnchor,
                                        constant: ViewSizeConstants.topPadding).isActive = true
        skipButton.rightAnchor.constraint(equalTo: view.rightAnchor,
                                          constant: ViewSizeConstants.rightPadding).isActive = true
        
        firstSmokeLabel.topAnchor.constraint(equalTo: skipButton.bottomAnchor,
                                             constant: ViewSizeConstants.topPadding).isActive = true
        firstSmokeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        firstSmokeDate.topAnchor.constraint(equalTo: firstSmokeLabel.bottomAnchor,
                                            constant: ViewSizeConstants.topPadding).isActive = true
        firstSmokeDate.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        averageCigarettesLabel.topAnchor.constraint(equalTo: firstSmokeDate.bottomAnchor,
                                                    constant: ViewSizeConstants.topPadding).isActive = true
        averageCigarettesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        averageCigarettesTextField.topAnchor.constraint(equalTo: averageCigarettesLabel.bottomAnchor,
                                                        constant: ViewSizeConstants.topPadding).isActive = true
        averageCigarettesTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: ViewSizeConstants.leftPadding).isActive = true
        averageCigarettesTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: ViewSizeConstants.rightPadding).isActive = true
        averageCigarettesTextField.heightAnchor.constraint(equalToConstant: ViewSizeConstants.itemHeight).isActive = true
        
        acceptButton.leftAnchor.constraint(equalTo: averageCigarettesTextField.leftAnchor).isActive = true
        acceptButton.rightAnchor.constraint(equalTo: averageCigarettesTextField.rightAnchor).isActive = true
        acceptButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: ViewSizeConstants.bottomPadding).isActive = true
        acceptButton.heightAnchor.constraint(equalToConstant: ViewSizeConstants.itemHeight).isActive = true
    }
    
    private func settings() {
        view.backgroundColor = .appBackgroundColor
        
        view.addSubview(skipButton)
        view.addSubview(firstSmokeDate)
        view.addSubview(firstSmokeLabel)
        view.addSubview(averageCigarettesLabel)
        view.addSubview(averageCigarettesTextField)
        view.addSubview(acceptButton)
        
        setupTextFields()
    }
    
    
    private func setupTextFields() {
        let toolbar = UIToolbar()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                        target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: ViewTextConstants.doneButton.rawValue.localize(from: RestoreDataView.localizedName), style: .done,
                                         target: self, action: #selector(doneButtonTapped))
        
        toolbar.setItems([flexSpace, doneButton], animated: true)
        toolbar.sizeToFit()
        
        averageCigarettesTextField.inputAccessoryView = toolbar
    }
    
    @objc private func doneButtonTapped() {
        view.endEditing(true)
    }
    
    @objc private func countCigarettes() {
        if let cigarettes = Int(averageCigarettesTextField.text ?? "0") {
            presenter.countTotalCigarettes(firstSmokeDate.date, cigarettesPerDay: cigarettes)
        }
        goToMainVC()
    }
    
    @objc private func goToMainVC() {
        presenter.goToMainView()
    }

    //MARK: - CONSTANTS
    
    private enum ViewSizeConstants {
        static let topPadding: CGFloat = 20
        static let rightPadding: CGFloat = -30
        static let leftPadding: CGFloat = 30
        static let bottomPadding: CGFloat = -30
        static let itemHeight: CGFloat = 50
        static let cornerRadius: CGFloat = 15
    }
    
    private enum ViewTextConstants: String {
        case doneButton
        case neverSmokedButton
        case chooseDayLabel
        case averageCigarettes
    }
    
}

extension RestoreDataView: RestoreDataViewProtocol {
    
}
