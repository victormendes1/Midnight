//
//  Extension + String.swift
//  Midnight
//
//  Created by Victor Mendes on 14/12/22.
//

import Foundation

extension String {
    func toDate(format: String = "yyyy-MM-dd") -> Date? {
        let formatter = DateFormatter()
        formatter.locale = .init(identifier: "us")
        formatter.timeZone = .current
        formatter.dateFormat = format
        guard let date = formatter.date(from: self) else { return nil }
        return date
    }
    
    /// function returns the formatted date example: **October 3, 2022**
    func longFormattedDate() -> String {
        let formatter = DateFormatter()
        formatter.locale = .init(identifier: "us")
        formatter.timeZone = .current
        formatter.dateFormat = "yyyy-MM-dd"
        guard let date = formatter.date(from: self) else { return "" }
        formatter.dateStyle = .long
        return formatter.string(from: date)
    }
}
