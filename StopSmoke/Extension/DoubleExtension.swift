//
//  DoubleExtension.swift
//  StopSmoke
//
//  Created by Marat on 30.11.2022.
//

import Foundation

extension Double {
    
    func roundToPlace() -> String {
        return String(format: "%.1f", self)
    }
    
}
