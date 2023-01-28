//
//  Extension + UIFont.swift
//  Midnight
//
//  Created by Victor Mendes on 03/11/22.
//

import UIKit

extension UIFont {
    enum PoppinsTypes: String {
        case Bold
        case ExtraBold
    }
    
    static func poppins(type: PoppinsTypes, size: CGFloat = UIFont.systemFontSize) -> UIFont {
        UIFont.init(name: "Poppins-\(type)", size: size)!
    }
}
