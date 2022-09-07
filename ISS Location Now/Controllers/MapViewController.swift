//
//  ViewController.swift
//  ISS Location Now
//
//  Created by Saruululzii on 9/6/22.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    private var networkManager: NetworkManager = NetworkManager()
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        startRealtime()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
    }
    
    func startRealtime() {
        timer = Timer.scheduledTimer(withTimeInterval: Constants.fetchInterval, repeats: true) { _ in
            self.loadPositions()
        }
    }
    
    func loadPositions() {
        networkManager.get(Constants.API_URL, parameters: nil)
        networkManager.successBlock = { data in
            if let data = data {
                if let coordinates = try? JSONDecoder().decode(ISSPosition.self, from: data) {
                    let coordinates = coordinates.iss_position
                    DispatchQueue.main.async {
                        let location = CLLocationCoordinate2D(
                            latitude: Double(coordinates.latitude) ?? 0.0,
                            longitude: Double(coordinates.longitude) ?? 0.0)
                        self.setMapRegion(location: location)
                        self.addPinPoint(location: location)
                    }
                }
            }
            
        }
        
        networkManager.failureBlock = { error in
            if let error = error as? NSError {
                print("Error code: \(error.code), Description: \(error.localizedDescription)")
            }
        }
    }
    
    func setMapRegion(location: CLLocationCoordinate2D) {
        guard location.longitude != 0.0 && location.latitude != 0.0 else {
            return
        }
        
        mapView.setRegion(MKCoordinateRegion.init(
            center: location,
            latitudinalMeters: CLLocationDistance(Constants.latitudinalMeters),
            longitudinalMeters: CLLocationDistance(Constants.longitudinalMeters)
        ), animated: true)
    }
    
    func addPinPoint(location: CLLocationCoordinate2D) {
        guard location.longitude != 0.0 && location.latitude != 0.0 else {
            return
        }
        
        mapView.annotations.forEach { annotation in
            mapView.removeAnnotation(annotation)
        }
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        mapView.addAnnotation(annotation)
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseIdentifier = "pin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        
        annotationView?.image = UIImage(named: Constants.annotationCustomImageName)
        return annotationView
    }
}
