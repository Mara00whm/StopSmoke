//
//  PopUpView.swift
//  StopSmoke
//
//  Created by Marat on 29.11.2022.
//

import UIKit

class CustomPopUPVC: UIView {
    
    var action: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        self.frame = UIScreen.main.bounds
        createAnchors()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setInfo(errorDesc: String, action: @escaping ()->() ) {
        self.subtitleLabel.text = errorDesc
        self.action = action
    }
    
    @objc func updateView() {
    
        if let action = action {
            action()
        }
        animateOut()
    }

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.error
        label.font = UIFont.systemFont(ofSize: Constants.titleSize,
                                       weight: .bold)
        label.textColor = .appBackgroundColor
        label.textAlignment = .center
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Reload page"
        label.font = UIFont.systemFont(ofSize: Constants.subtitleSize,
                                       weight: .bold)
        label.textColor = .appBackgroundColor
        label.textAlignment = .center
        label.numberOfLines = 3
        return label
    }()
    
    private let container: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .viewBackgroundColor
        view.layer.cornerRadius = Constants.viewCornerRadius
        return view
    }()
    
    private let closeButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .appBackgroundColor
        view.layer.cornerRadius = Constants.buttonDefaultCornerRadius
        view.setTitle(Constants.close, for: .normal)
        view.setTitleColor(UIColor.viewBackgroundColor, for: .normal)
        view.role = .destructive
        view.addTarget(self, action: #selector(animateOut), for: .touchUpInside)
        return view
    }()
    
    private let updateButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = Constants.buttonDefaultCornerRadius
        view.setTitle(Constants.update, for: .normal)
        view.addTarget(self, action: #selector(updateView), for: .touchUpInside)
        return view
    }()
    
    private lazy var stack: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        return stack
    }()
    
    @objc private func animateOut() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn) {
            self.container.transform = CGAffineTransform(translationX: 0, y: -self.frame.height)
        } completion: { complete in
            if complete {
                self.removeFromSuperview()
            }
        }
    }
    
    private func createAnchors() {
        self.addSubview(container)
        
        container.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        container.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        container.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: Constants.containerWidthMult).isActive = true
        container.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: Constants.containerHeightMult).isActive = true
        
        container.addSubview(stack)
        
        stack.leftAnchor.constraint(equalTo: container.leftAnchor).isActive = true
        stack.rightAnchor.constraint(equalTo: container.rightAnchor).isActive = true
        stack.topAnchor.constraint(equalTo: container.topAnchor, constant: 5).isActive = true
        stack.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: Constants.containerHeightMult).isActive = true
        
        container.addSubview(closeButton)
        
        closeButton.leftAnchor.constraint(equalTo: container.leftAnchor, constant: Constants.leftPadding).isActive = true
        closeButton.rightAnchor.constraint(equalTo: container.rightAnchor, constant: Constants.rightPadding).isActive = true
        closeButton.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: Constants.bottomPadding).isActive = true
        closeButton.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: Constants.buttonHeightMult).isActive = true
        
        container.addSubview(updateButton)
        
        updateButton.leftAnchor.constraint(equalTo: container.leftAnchor, constant:
                                            Constants.leftPadding).isActive = true
        updateButton.rightAnchor.constraint(equalTo: container.rightAnchor, constant: Constants.rightPadding).isActive = true
        updateButton.bottomAnchor.constraint(equalTo: closeButton.topAnchor, constant: Constants.topPadding).isActive = true
        updateButton.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: Constants.buttonHeightMult).isActive = true
    }
    
    private enum Constants {
        static let error: String = "Got error"
        static let update: String = "Reload"
        static let close: String = "Close"
        
        
        static let titleSize: CGFloat = 28
        static let subtitleSize: CGFloat = 18
        static let viewCornerRadius: CGFloat = 24
        static let buttonDefaultCornerRadius: CGFloat = 15
        
        static let rightPadding: CGFloat = -10
        static let leftPadding: CGFloat = 10
        static let topPadding: CGFloat = -10
        static let bottomPadding: CGFloat = -10
        
        static let containerWidthMult: CGFloat = 0.6
        static let containerHeightMult: CGFloat = 0.45
        
        static let buttonHeightMult: CGFloat = 0.15
    }
}
