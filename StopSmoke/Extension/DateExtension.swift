//
//  DateExtension.swift
//  StopSmoke
//
//  Created by Marat on 23.11.2022.
//

import Foundation

extension Date {

    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }

    func convertDateToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, YY"
        return dateFormatter.string(from: self)
    }
    
    func compareDate(_ date: Date) -> Bool {
        return Calendar.current.isDate(self, equalTo: date, toGranularity: .day)
    }
    
}

extension TimeInterval {
    func timeString() -> String {
        let hours = Int(self) / 3600
        let minutes = Int(self) / 60 % 60
        let seconds = Int(self) % 60
        return String(format:"%02i h : %02i m : %02i s", hours, minutes, seconds)
    }
}
