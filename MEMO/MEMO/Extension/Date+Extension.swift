//
//  Date+Extension.swift
//  MEMO
//
//  Created by OHSEUNGMIN on 2021/11/08.
//

import Foundation

extension Date {
    func toString() -> String {
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
