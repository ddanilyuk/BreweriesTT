//
//  UIResponder+Extensions.swift
//  BreweriesTT
//
//  Created by Денис Данилюк on 25.10.2020.
//

import UIKit

extension UIResponder {
    
    static var identifier: String {
        return String(describing: self)
    }
    
}
