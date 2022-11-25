//
//  TodayInfoTVC.swift
//  StopSmoke
//
//  Created by Marat on 26.11.2022.
//

import UIKit

class TodayInfoTVC: UITableViewCell {

    // MARK: - Views
    private let dateLabel: UILabel = {
       let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .appBackgroundColor
        return view
    }()
    
    private let cigaretteNumber: UILabel = {
       let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .appBackgroundColor
        return view
    }()
    
    //MARK: - OVERRIDE FUNCS
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .viewBackgroundColor
        contentView.addSubview(dateLabel)
        contentView.addSubview(cigaretteNumber)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        createAnchors()
    }
    
    //MARK: - SETTING FUNCS
    func setInfo(_ day: Date, numberOfCigarette: Int) {
        let df = DateFormatter()
        df.dateStyle = .none
        df.timeStyle = .full
        df.dateFormat = "HH : mm"
        dateLabel.text = df.string(from: day)
        cigaretteNumber.text = "\(numberOfCigarette) cigarette"
    }
    
    private func createAnchors() {
        dateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15).isActive = true
        dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15).isActive = true
        
        cigaretteNumber.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        cigaretteNumber.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
}

