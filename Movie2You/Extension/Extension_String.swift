//
//  Extension_String.swift
//  Movie2You
//
//  Created by Victor Mendes on 08/01/22.
//

import Foundation

extension String {
    public func onlyYear() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-mm-dd"
        guard let data = formatter.date(from: self) else { return "" }
        formatter.dateFormat = "yyyy"
        return formatter.string(from: data)
    }
}
