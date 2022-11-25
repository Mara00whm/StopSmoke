//
//  DefaultAppButton.swift
//  StopSmoke
//
//  Created by Marat on 21.11.2022.
//

import UIKit

class DefaultAppButton: UIButton {
    
    //MARK: - OVERRIDE FUNCS
    override init(frame: CGRect) {
        super.init(frame: frame)
        setting()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - SETTING FUNCS
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? .gray : .acceptButton
        }
    }
    
    private func setting() {
        backgroundColor = .acceptButton
        setTitleColor(.appBackgroundColor , for: .normal)
        layer.cornerRadius = 15
        layer.masksToBounds = true
    }
    
    func setTitle(_ title: String) {
        setTitle(title, for: .normal)
    }
}
