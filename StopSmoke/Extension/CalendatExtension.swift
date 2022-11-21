//
//  CalendatExtension.swift
//  StopSmoke
//
//  Created by Marat on 21.11.2022.
//

import Foundation

extension Date {

    func days() -> Int? {
        return Calendar.current.dateComponents([.day], from: self, to: Date()).day
    }

}
