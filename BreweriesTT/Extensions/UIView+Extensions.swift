//
//  UIView+Extensions.swift
//  BreweriesTT
//
//  Created by Денис Данилюк on 24.10.2020.
//

import UIKit

extension UIView {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UIViewController {
    static var identifier: String {
        return String(describing: self)
    }
}
