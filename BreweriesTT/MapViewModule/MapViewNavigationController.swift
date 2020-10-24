//
//  MapViewNavigationController.swift
//  BreweriesTT
//
//  Created by Денис Данилюк on 24.10.2020.
//

import UIKit
import MapKit

class MapViewNavigationController: UINavigationController {

    var statusBarStyle = UIStatusBarStyle.default { didSet { setNeedsStatusBarAppearanceUpdate() } }
    override var preferredStatusBarStyle: UIStatusBarStyle { statusBarStyle }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    static func instantiateMapViewControllerWithNavigation(with location: CLLocation, name: String) -> MapViewNavigationController? {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        guard let navigataionController = storyboard.instantiateViewController(withIdentifier: String(describing: MapViewNavigationController.self)) as? MapViewNavigationController else { return nil }
        
        guard let mapViewController = navigataionController.viewControllers.first as? MapViewController else { return nil }
        mapViewController.initialLocation = location
        mapViewController.initialLocationName = name
        mapViewController.title = name
        
        return navigataionController
    }
    
}
