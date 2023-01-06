//
//  Extension + Double.swift
//  Midnight
//
//  Created by Victor Mendes on 01/11/22.
//

import Foundation

extension Double {
    mutating func roundToPlaces(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return Darwin.round(self * divisor) / divisor
    }
    
    func removeFloatingPoint() -> Double {
        let noPunctuation = self.description.replacingOccurrences(of: ".", with: "")
        return Double(noPunctuation) ?? .zero
    }
    
    func shortening(previous text: String = "") -> String {
        var thousandNum = self/1000
        var millionNum = self/1000000
        if self >= 1000 && self < 1000000{
            if floor(thousandNum) == thousandNum {
                return "\(Int(thousandNum))k"
            }
            return "\(thousandNum.roundToPlaces(places: 1))k \(text)"
        }
        if self > 1000000 {
            if floor(millionNum) == millionNum {
                return "\(Int(thousandNum))k"
            }
            return "\(millionNum.roundToPlaces(places: 1))M \(text)"
        }
        else {
            if floor(self) == self {
                return "\(Int(self))"
            }
            return ("\(self)")
        }
    }
}
