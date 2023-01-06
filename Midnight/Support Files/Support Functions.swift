//
//  Extra Functions.swift
//  Midnight
//
//  Created by Victor Mendes on 09/01/22.
//

import UIKit

// MARK:  - Support Functions
///In order not to pollute the ViewModel and View, I have separated these functions in this support file

//To get the API key that is in the Xcode variable environment
func getEnvironmentVar(_ name: String) -> String {
    guard let rawValue = getenv(name) else { return "No key found" }
    let toString = String(utf8String: rawValue) ?? "Could not convert key"
    return toString
}

// Function responsible for adding shadow on top of the background image on the main screen
// place - will be the place where the shadow will be applied
// and leftButton is there is a need to add a button to the left
func addShadowTop(place: UIView, leftButton: UIButton? = nil) {
    let shadow = CAGradientLayer()
    shadow.colors = [UIColor.black.withAlphaComponent(0.8).cgColor , UIColor.clear.cgColor]
    let viewTop = UIView(frame: CGRect(x: 0, y: 0, width: place.bounds.width, height: 80))
    shadow.frame = viewTop.frame
    viewTop.layer.addSublayer(shadow)
    place.addSubview(viewTop)
    if let _leftButton = leftButton {
        place.addSubview(_leftButton)
    }
}
//Function responsible for adding shadow at the bottom of the Header View
func addShadowBottom(_ headerView: StretchyHeaderView) {
    let shadow = CAGradientLayer()
    shadow.colors = [UIColor.clear.cgColor, UIColor.clear.cgColor, UIColor.clear.cgColor, #colorLiteral(red: 0.04129081964, green: 0.04129078984, blue: 0.04129078984, alpha: 1).cgColor] // TODO: - Melhorar a forma em que aplico essas cores
    shadow.frame = headerView.frame
    headerView.layer.addSublayer(shadow)
}
