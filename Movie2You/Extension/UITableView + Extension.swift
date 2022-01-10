//
//  UITableView + Extension.swift
//  Movie2You
//
//  Created by Victor Mendes on 08/01/22.
//

import UIKit

extension UITableView {
    func register(type: UITableViewCell.Type) {
        let identifier = type.reuseIdentifier
        self.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }

    func dequeueReusableCell<Type: UITableViewCell> (_ indexPath: IndexPath) -> Type {
        return dequeueReusableCell(
            withIdentifier: Type.self.reuseIdentifier,
            for: indexPath) as! Type
    }
}

extension UITableViewCell {
    static var reuseIdentifier: String { return String(describing: self) }
}
