//
//  UIFont+Extensions.swift
//  BreweriesTT
//
//  Created by Денис Данилюк on 23.10.2020.
//

import UIKit

public extension UIFont {
    
    enum iowanOldStyle: String {
        case bold = "IowanOldStyle-Bold"
        case boldItalic = "IowanOldStyle-BoldItalic"
        case italic = "IowanOldStyle-Italic"
        case roman = "IowanOldStyle-Roman"
        
        public func font(size: CGFloat) -> UIFont {
            return UIFont(name: self.rawValue, size: size)!
        }
    }
    
}
