//
//  StringExtension.swift
//  StopSmoke
//
//  Created by Marat on 03.12.2022.
//

import Foundation

extension String {
    
    func convertStringToDate() -> Date? {
        let df = DateFormatter()
        df.dateFormat = "MMM d, YY"
        return df.date(from: self)
    }
    
}
