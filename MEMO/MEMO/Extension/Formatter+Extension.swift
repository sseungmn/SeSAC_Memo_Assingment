//
//  Date+Extension.swift
//  MEMO
//
//  Created by OHSEUNGMIN on 2021/11/08.
//

import Foundation

extension Date {
    func toFormattedString() -> String {
        let calendar = Calendar.current
        let today = Date()
        let formatter = DateFormatter()
        
        if calendar.compare(today, to:self, toGranularity: .day) == .orderedSame {
            formatter.dateFormat = "a hh:mm"
        } else if calendar.compare(today, to: self, toGranularity: .weekOfYear) == .orderedSame {
            formatter.dateFormat = "EEEE"
        } else {
            formatter.dateFormat = "yyyy.MM.dd a hh:mm"
        }
        return formatter.string(from: self)
    }
}

extension Int {
    func toFormattedNumber() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(for: self)!
    }
}
