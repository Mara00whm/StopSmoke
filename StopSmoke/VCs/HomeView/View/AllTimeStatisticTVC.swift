//
//  AllTimeStatisticTVC.swift
//  StopSmoke
//
//  Created by Marat on 24.11.2022.
//

import UIKit

class AllTimeStatisticTVC: UITableViewCell {

    // MARK: - Views
    private let dateLabel: UILabel = {
       let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .appBackgroundColor
        return view
    }()
    
    private let totalCigarettes: UILabel = {
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
        contentView.addSubview(totalCigarettes)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        createAnchors()
    }
    
    //MARK: - SETTING FUNCS
    func setInfo(_ s: String, countCigarettes: Int64) {
        dateLabel.text = s
        totalCigarettes.text = "\(countCigarettes)"
    }
    
    private func createAnchors() {
        dateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: ViewSizeConstants.leftPadding).isActive = true
        dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: ViewSizeConstants.topPadding).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: ViewSizeConstants.bottomPadding).isActive = true
        
        totalCigarettes.leftAnchor.constraint(equalTo: dateLabel.rightAnchor, constant: ViewSizeConstants.leftPadding).isActive = true
        totalCigarettes.topAnchor.constraint(equalTo: dateLabel.topAnchor).isActive = true
        totalCigarettes.bottomAnchor.constraint(equalTo: dateLabel.bottomAnchor).isActive = true
    }
    
    private enum ViewSizeConstants {
        static let topPadding: CGFloat = 15
        static let leftPadding: CGFloat = 15
        static let bottomPadding: CGFloat = -15
    }

}
