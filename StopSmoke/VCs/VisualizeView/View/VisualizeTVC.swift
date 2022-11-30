//
//  VisualizeTVC.swift
//  StopSmoke
//
//  Created by Marat on 29.11.2022.
//

import UIKit

class VisualizeTVC: UITableViewCell {

    // MARK: - Views
    
    private let itemImage: UIImageView = {
       let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let itemName: UILabel = {
       let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .appBackgroundColor
        view.numberOfLines = 0
        return view
    }()
    
    private let procentLabel: UILabel = {
       let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .appBackgroundColor
        return view
    }()
    
    private let progressView: UIProgressView = {
       let view = UIProgressView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = .appBackgroundColor
        return view
    }()
    
    //MARK: - OVERRIDE FUNCS
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .viewBackgroundColor
        contentView.addSubview(itemName)
        contentView.addSubview(procentLabel)
        contentView.addSubview(itemImage)
        contentView.addSubview(progressView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        createAnchors()
    }
    
    override func prepareForReuse() {
        itemImage.image = nil
    }
    //MARK: - SETTING FUNCS
    func setInfo(imageName: String, desc: String, value: Double, cigarettesMetres: Double) {
        let procentValue = (cigarettesMetres/value)*100
        itemName.text = desc + " (\(value) metres)"
        itemImage.image = UIImage(named: imageName)
        procentLabel.text = "\(Int(procentValue))%"
        progressView.setProgress(Float(cigarettesMetres/value), animated: false)
    
    }
    
    private func createAnchors() {
        itemName.leftAnchor.constraint(equalTo: contentView.leftAnchor,
                                       constant: ViewSizeConstants.leftPadding).isActive = true
        itemName.topAnchor.constraint(equalTo: contentView.topAnchor,
                                      constant: ViewSizeConstants.topPadding).isActive = true
        itemName.rightAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        itemImage.topAnchor.constraint(equalTo: contentView.topAnchor,
                                       constant: ViewSizeConstants.topPadding).isActive = true
        itemImage.rightAnchor.constraint(equalTo: contentView.rightAnchor,
                                         constant: ViewSizeConstants.rightPadding).isActive = true
        itemImage.leftAnchor.constraint(equalTo: contentView.centerXAnchor,
                                        constant: ViewSizeConstants.leftPadding).isActive = true
        itemImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                          constant: ViewSizeConstants.bottomPadding).isActive = true
        
        procentLabel.bottomAnchor.constraint(equalTo: progressView.topAnchor,
                                             constant: ViewSizeConstants.procentBotPadding).isActive = true
        procentLabel.centerXAnchor.constraint(equalTo: progressView.centerXAnchor).isActive = true

        progressView.leftAnchor.constraint(equalTo: itemName.leftAnchor).isActive = true
        progressView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                             constant: ViewSizeConstants.bottomPadding).isActive = true
        progressView.rightAnchor.constraint(equalTo: itemName.rightAnchor).isActive = true
    }
    
    private enum ViewSizeConstants {
        static let leftPadding: CGFloat = 15
        static let topPadding: CGFloat = 15
        static let rightPadding: CGFloat = -15
        static let bottomPadding: CGFloat = -15
        
        static let procentBotPadding: CGFloat = -5
    }
}
