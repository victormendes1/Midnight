//
//  Extension + Int.swift
//  Midnight
//
//  Created by Victor Mendes on 05/01/23.
//

extension Int {
    var formattedDuration: String? {
        let duratioInSeconds = self * 60
        let hours = duratioInSeconds / 3600
        let minutes = (duratioInSeconds % 3600) / 60
        
        if minutes == .zero {
            return "\(hours)h"
        } else {
            return "\(hours)h \(minutes)min"
        }
    }
}
