//
//  UIView+Extensions.swift
//  BreweriesTT
//
//  Created by Денис Данилюк on 24.10.2020.
//

import UIKit

extension UIView {
        
    func fadeTransition(_ duration: CFTimeInterval, isFromLeftToRight: Bool) {
        let transition = CATransition()
        transition.duration = duration
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)
        transition.type = CATransitionType.moveIn
        transition.subtype = isFromLeftToRight ? .fromLeft : .fromRight
        
        layer.add(transition, forKey: nil)
    }
    
}
