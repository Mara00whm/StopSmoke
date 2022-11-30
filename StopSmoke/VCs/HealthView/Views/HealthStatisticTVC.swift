//
//  HealthStatisticTVC.swift
//  StopSmoke
//
//  Created by Marat on 30.11.2022.
//

import UIKit

class HealthStatisticTVC: UITableViewCell {

    // MARK: - Views
    
    private let cellImage: UIImageView = {
       let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFit
        view.tintColor = .appBackgroundColor
        return view
    }()
    
    private let cellDescLabel: UILabel = {
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
        view.textAlignment = .center
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
        contentView.addSubview(cellDescLabel)
        contentView.addSubview(procentLabel)
        contentView.addSubview(cellImage)
        contentView.addSubview(progressView)
        createAnchors()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        cellImage.image = nil
    }
    //MARK: - SETTING FUNCS
    func setInfo(image: UIImage, desctiprion: String, timeNeed: Double, timePassed: Double) {
        let procentValue = (timePassed/timeNeed)*100 >= 100 ? 100 : (timePassed/timeNeed)*100
        cellDescLabel.text = desctiprion
        print(desctiprion)
        cellImage.image = image
        procentLabel.text = "\(Int(procentValue))%"
        progressView.setProgress(Float(timePassed/timeNeed), animated: false)  
    }
    
    private func createAnchors() {
        NSLayoutConstraint.activate([
            cellImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: ViewSizeConstants.leftPadding),
            cellImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: ViewSizeConstants.topPadding),
            cellImage.widthAnchor.constraint(equalToConstant: ViewSizeConstants.imageSize),
            cellImage.heightAnchor.constraint(equalToConstant: ViewSizeConstants.imageSize),
            
            cellDescLabel.leftAnchor.constraint(equalTo: cellImage.rightAnchor, constant: ViewSizeConstants.leftPadding),
            cellDescLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: ViewSizeConstants.rightPadding),
            cellDescLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: ViewSizeConstants.topPadding),

            procentLabel.topAnchor.constraint(equalTo: cellDescLabel.bottomAnchor, constant: ViewSizeConstants.topPadding),
            procentLabel.rightAnchor.constraint(equalTo: cellDescLabel.rightAnchor),
            procentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: ViewSizeConstants.bottomPadding),

            progressView.leftAnchor.constraint(equalTo: cellImage.leftAnchor),
            progressView.rightAnchor.constraint(equalTo: procentLabel.leftAnchor, constant: ViewSizeConstants.rightPadding),
            progressView.centerYAnchor.constraint(equalTo: procentLabel.centerYAnchor),
        ])
    }
    
    private enum ViewSizeConstants {
        static let leftPadding: CGFloat = 5
        static let topPadding: CGFloat = 5
        static let rightPadding: CGFloat = -5
        static let bottomPadding: CGFloat = -15
        
        static let imageSize: CGFloat = 30
    }
}
