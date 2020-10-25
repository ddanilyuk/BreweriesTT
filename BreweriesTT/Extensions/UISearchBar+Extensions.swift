//
//  UISearchBar+Extensions.swift
//  BreweriesTT
//
//  Created by Денис Данилюк on 24.10.2020.
//

import UIKit

extension UISearchBar {
    
    public var textField: UITextField? {
        if #available(iOS 13, *) {
            return searchTextField
        }
        let subViews = subviews.flatMap { $0.subviews }
        guard let textField = (subViews.filter { $0 is UITextField }).first as? UITextField else {
            return nil
        }
        return textField
    }
    
    private var activityIndicator: UIActivityIndicatorView? {
        return textField?.leftView?.subviews.compactMap{ $0 as? UIActivityIndicatorView }.first
    }

    var isLoading: Bool {
        get {
            return activityIndicator != nil
        } set {
            if newValue {
                if activityIndicator == nil {
                    let newActivityIndicator = UIActivityIndicatorView(style: .gray)
                    newActivityIndicator.startAnimating()
                    if #available(iOS 13.0, *) {
                        newActivityIndicator.backgroundColor = UIColor.systemGroupedBackground
                    } else {
                        newActivityIndicator.backgroundColor = UIColor.groupTableViewBackground
                    }
                    newActivityIndicator.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                    textField?.leftView?.addSubview(newActivityIndicator)
                    let leftViewSize = textField?.leftView?.frame.size ?? CGSize.zero
                    newActivityIndicator.center = CGPoint(x: leftViewSize.width / 2, y: leftViewSize.height / 2)
                }
            } else {
                activityIndicator?.removeFromSuperview()
            }
        }
    }
    
    func setCenteredPlaceHolder(animated: Bool) {
        let textFieldInsideSearchBar = self.textField
        
        //get the sizes
        let searchBarWidth = self.frame.width
        let placeholderIconWidth = textFieldInsideSearchBar?.leftView?.frame.width
        let placeHolderWidth = textFieldInsideSearchBar?.attributedPlaceholder?.size().width
        let offsetIconToPlaceholder: CGFloat = 8
        let placeHolderWithIcon = placeholderIconWidth! + offsetIconToPlaceholder
        let offset = UIOffset(horizontal: ((searchBarWidth / 2) - (placeHolderWidth! / 2) - placeHolderWithIcon) - 10, vertical: 0)
        
        if animated {
            self.textField?.subviews[2].fadeTransition(0.3, isFromLeftToRight: true)
            self.textField?.leftView?.fadeTransition(0.3, isFromLeftToRight: true)
        }
        
        self.setPositionAdjustment(offset, for: .search)
    }
    
    func setLeftPlaceHolder(animated: Bool) {
        let offset = UIOffset(horizontal: 0, vertical: 0)
        if animated {
            self.textField?.subviews[2].fadeTransition(0.3, isFromLeftToRight: false)
            self.textField?.leftView?.fadeTransition(0.3, isFromLeftToRight: false)
        }
        self.setPositionAdjustment(offset, for: .search)
    }
    
}
