//
//  CalendarView.swift
//  StopSmoke
//
//  Created by Marat on 02.12.2022.
//

import UIKit
import FSCalendar

class CalendarView: UIViewController {
    
    var presenter: CalendarPresenterProtocol!
    //MARK: - VIEWS
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .appBackgroundColor
        view.alwaysBounceVertical = true
        view.delaysContentTouches = false
        view.keyboardDismissMode = .onDrag
        return view
    }()
    
    private let contentView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .appBackgroundColor
        return view
    }()
    
    private let closeButton: UIButton = {
       let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setImage(UIImage.closeViewImage, for: .normal)
        view.tintColor = .viewBackgroundColor
        view.addTarget(self, action: #selector(popToRoot), for: .touchUpInside)
        return view
    }()
    
    private let saveButton: UIButton = {
       let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Save", for: .normal)
        view.tintColor = .viewBackgroundColor
        view.addTarget(self, action: #selector(saveWellbeing), for: .touchUpInside)
        view.setTitleColor(UIColor.yellow, for: .highlighted)
        return view
    }()
    
    private let headerLabel: UILabel = {
       let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .viewBackgroundColor
        view.text = "Calendar"
        view.font = UIFont.boldSystemFont(ofSize: ViewSizeConstants.headerSize)
        return view
    }()
    
    private let calendarUIView: FSCalendar = {
       let view = FSCalendar()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = ViewSizeConstants.cornerRadius
        view.scrollDirection = .horizontal
        view.scope = .month
        view.backgroundColor = .viewBackgroundColor
        view.appearance.headerTitleColor = .appBackgroundColor
        view.appearance.weekdayTextColor = .appBackgroundColor
        view.select(Date())
        return view
    }()
    
    private let wellbeingView: UITextView = {
       let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = .viewBackgroundColor
        view.textColor = .appBackgroundColor
        view.layer.cornerRadius = ViewSizeConstants.cornerRadius
        view.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 0, right: 0)
        return view
    }()
    
    //MARK: - OVERRIDE FUNCS
    
    override func loadView() {
        super.loadView()
        settings()
        view.backgroundColor = .appBackgroundColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerKeyboardNotifications()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createAnchors()
        presenter.loadView()
    }
    
    //MARK: - SETTING FUNCS
    
    private func settings() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.isHidden = true
        scrollView.addSubview(headerLabel)
        scrollView.addSubview(closeButton)
        scrollView.addSubview(calendarUIView)
        scrollView.addSubview(wellbeingView)
        scrollView.addSubview(saveButton)

        calendarUIView.dataSource = self
        calendarUIView.delegate = self

        calendarUIView.appearance.selectionColor = .red
    }
    
    private func createAnchors(){
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            headerLabel.topAnchor.constraint(equalTo: contentView.topAnchor,
                                             constant: ViewSizeConstants.headerTopPadding),
            headerLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            closeButton.leftAnchor.constraint(equalTo: contentView.leftAnchor,
                                              constant: ViewSizeConstants.leftPadding),
            closeButton.centerYAnchor.constraint(equalTo: headerLabel.centerYAnchor),
            
            saveButton.rightAnchor.constraint(equalTo: contentView.rightAnchor,
                                              constant: ViewSizeConstants.rightPadding),
            saveButton.centerYAnchor.constraint(equalTo: headerLabel.centerYAnchor),
            
            calendarUIView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor,
                                                constant: ViewSizeConstants.topPadding),
            calendarUIView.leftAnchor.constraint(equalTo: contentView.leftAnchor,
                                                 constant: ViewSizeConstants.leftPadding),
            calendarUIView.rightAnchor.constraint(equalTo: contentView.rightAnchor,
                                                  constant: ViewSizeConstants.rightPadding),
            calendarUIView.heightAnchor.constraint(equalToConstant: ViewSizeConstants.calendarHeight),
            
            wellbeingView.topAnchor.constraint(equalTo: calendarUIView.bottomAnchor,
                                               constant: ViewSizeConstants.headerTopPadding),
            wellbeingView.leftAnchor.constraint(equalTo: calendarUIView.leftAnchor),
            wellbeingView.rightAnchor.constraint(equalTo: calendarUIView.rightAnchor),
            wellbeingView.heightAnchor.constraint(equalToConstant: ViewSizeConstants.textViewHeight),
        ])
    }
    
    @objc private func saveWellbeing() {
        if let selectedDate = calendarUIView.selectedDate,
           selectedDate.compareDate(Date() ) {
            presenter.saveWellbeing(wellbeingView.text)
            popToRoot()
        }
    }
    
    @objc private func popToRoot() {
        presenter.popToRoot()
    }
    
    //MARK: - Enum constants
    
    enum ViewSizeConstants {
        static let headerTopPadding: CGFloat = 5
        static let leftPadding: CGFloat = 10
        static let rightPadding: CGFloat = -10
        static let topPadding: CGFloat = 15

        static let calendarHeight: CGFloat = 300
        static let textViewHeight: CGFloat = 200
        
        static let headerSize: CGFloat = 35
        
        static let cornerRadius: CGFloat = 15
    }
}

extension CalendarView: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {

    func maximumDate(for calendar: FSCalendar) -> Date {
        Date()
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        presenter.getWellbeingFor(date)
        if date.compareDate(Date()) {
            saveButton.isHidden = false
        } else {
            saveButton.isHidden = true
        }
        return true
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {

        for object in presenter.days {
            if object.day == date.convertDateToString() {
                return .appBackgroundColor
            }
        }
        if date.compareDate(Date()) {
            return .systemBlue
        }
            return .viewBackgroundColor
    
    }
    
}

extension CalendarView: CalendarViewProtocol {
    
    func setWellbeing(date: Date, _ string: String?) {
        wellbeingView.text = string ?? ""
        //Edit allow only current Date
        wellbeingView.isEditable = date.compareDate(Date())
    }
    
    func reloadData() {
        calendarUIView.reloadData()
    }
    
    
}

extension CalendarView {

    private func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIControl.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIControl.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrameValue = notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else { return }
        let keyboardFrame = view.convert(keyboardFrameValue.cgRectValue, from: nil)
        scrollView.contentOffset = CGPoint(x: 0, y: keyboardFrame.size.height)
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        scrollView.contentOffset = .zero
    }
}
