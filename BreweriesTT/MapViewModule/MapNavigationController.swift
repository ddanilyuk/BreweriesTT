//
//  MapViewNavigationController.swift
//  BreweriesTT
//
//  Created by Денис Данилюк on 24.10.2020.
//

import UIKit
import MapKit

class MapNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    static func instantiateMapViewControllerWithNavigation(with location: CLLocation, name: String) -> MapNavigationController? {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        guard let navigataionController = storyboard.instantiateViewController(withIdentifier: String(describing: MapNavigationController.self)) as? MapNavigationController else { return nil }
        
        guard let mapViewController = navigataionController.viewControllers.first as? MapViewController else { return nil }
        mapViewController.initialLocation = location
        mapViewController.initialLocationName = name
        mapViewController.title = name
        
        return navigataionController
    }
    
}
