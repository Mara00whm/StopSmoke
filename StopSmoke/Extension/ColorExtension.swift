//
//  ColorExtension.swift
//  StopSmoke
//
//  Created by Marat on 21.11.2022.
//

import UIKit

extension UIColor {
    
    static var appBackgroundColor: UIColor {
        UIColor(named: "backgroundColor") ?? UIColor.white
    }
 
    static var viewBackgroundColor: UIColor {
        UIColor(named: "viewBackgroundColor") ?? UIColor.black
    }
    
    static var acceptButton: UIColor {
        UIColor(named: "buttonBackgroundColor") ?? UIColor.blue
    }
    
}
