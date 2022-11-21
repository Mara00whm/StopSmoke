//
//  ColorExtension.swift
//  StopSmoke
//
//  Created by Marat on 21.11.2022.
//

import UIKit

extension UIColor {
    
    static var backgroundColor: UIColor {
        UIColor(named: "backgroundColor") ?? UIColor.white
    }
 
    static var textColor: UIColor {
        UIColor(named: "textColor") ?? UIColor.black
    }
    
    static var acceptButton: UIColor {
        UIColor(named: "buttonBackgroundColor") ?? UIColor.blue
    }
    
}
