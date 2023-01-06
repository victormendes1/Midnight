//
//  Alert.swift
//  Movie2You
//
//  Created by Victor Mendes on 04/11/22.
//

import UIKit

protocol Alert {
    func showAlert(_ title: String, _ message: String, _ view: UIViewController)
}

extension Alert {
    // Function responsible for presenting possible errors when the app is dealing with API
    func showAlert(_ title: String, _ message: String, _ view: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        view.present(alert, animated: true)
    }
}
