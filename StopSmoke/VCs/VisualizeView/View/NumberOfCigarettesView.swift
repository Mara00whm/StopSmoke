//
//  NumberOfCigarettesView.swift
//  StopSmoke
//
//  Created by Marat on 28.11.2022.
//

import UIKit

class NumberOfCigarettesView: UIView {

    //MARK: - VIEWS
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .viewBackgroundColor
        return view
    }()

    private let typeLabel: UILabel = {
       let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .appBackgroundColor
        return view
    }()
    
    private let countLabel: UILabel = {
       let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .appBackgroundColor
        return view
    }()
    
    //MARK: - OVERRIDE FUNCS
    
    init(title: String) {
        super.init(frame: .zero)
        typeLabel.text = title
        setting()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setValues(_ value: String) {
        countLabel.text = value
    }
    
    //MARK: - VIEW SETTING
    
    private func setting() {
        addSubview(contentView)
        contentView.addSubview(typeLabel)
        contentView.addSubview(countLabel)
        
        
        contentView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        typeLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        typeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        countLabel.leftAnchor.constraint(equalTo: typeLabel.rightAnchor, constant: 15).isActive = true
        countLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }

}
