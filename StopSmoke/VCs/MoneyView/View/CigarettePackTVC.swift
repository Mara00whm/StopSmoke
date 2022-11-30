//
//  CigarettePackTVC.swift
//  StopSmoke
//
//  Created by Marat on 30.11.2022.
//

import UIKit

class CigarettePackCell: UITableViewCell {

    // MARK: - Views
    private let dateLabel: UILabel = {
       let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .appBackgroundColor
        return view
    }()
    
    private let cigarettePackPrice: UILabel = {
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
        contentView.addSubview(cigarettePackPrice)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        createAnchors()
    }
    
    //MARK: - SETTING FUNCS
    func setInfo(_ s: Date, countCigarettes: Double) {
        let df = DateFormatter()
        df.dateFormat = "YYYY MMM d, HH : mm"
        df.locale = Locale(identifier: "en_US_POSIX")
        df.timeZone = TimeZone(identifier: "UTC")!
        
        dateLabel.text = df.string(from: s)
        cigarettePackPrice.text = "\(countCigarettes)$"
    }
    
    private func createAnchors() {
        dateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: ViewSizeConstants.leftPadding).isActive = true
        dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: ViewSizeConstants.topPadding).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: ViewSizeConstants.bottomPadding).isActive = true
        
        cigarettePackPrice.leftAnchor.constraint(equalTo: dateLabel.rightAnchor, constant: ViewSizeConstants.leftPadding).isActive = true
        cigarettePackPrice.topAnchor.constraint(equalTo: dateLabel.topAnchor).isActive = true
        cigarettePackPrice.bottomAnchor.constraint(equalTo: dateLabel.bottomAnchor).isActive = true
    }
    
    private enum ViewSizeConstants {
        static let topPadding: CGFloat = 15
        static let leftPadding: CGFloat = 15
        static let bottomPadding: CGFloat = -15
    }
}
