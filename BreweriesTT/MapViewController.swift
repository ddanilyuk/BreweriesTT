//
//  MapViewController.swift
//  BreweriesTT
//
//  Created by Денис Данилюк on 24.10.2020.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var initialLocation: CLLocation?
    var initialLocationName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        if let location = initialLocation {
            centerToLocation(location)
            
            let annotation = MKPointAnnotation()
            annotation.title = initialLocationName
            annotation.coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            mapView.addAnnotation(annotation)
        }
    }
    
    @IBAction func didPressClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 100) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}
