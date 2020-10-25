//
//  BreweriesNavigationController.swift
//  BreweriesTT
//
//  Created by Денис Данилюк on 23.10.2020.
//

import UIKit

class BreweriesNavigationController: UINavigationController {

    // Set status bar color to white
    var statusBarStyle = UIStatusBarStyle.lightContent { didSet { setNeedsStatusBarAppearanceUpdate() } }
    override var preferredStatusBarStyle: UIStatusBarStyle { statusBarStyle }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Change title text attributes
        let textAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.font : UIFont.iowanOldStyle.roman.font(size: 20)
        ]
        self.navigationBar.titleTextAttributes = textAttributes
    }
    
}
