//
//  PizzeriaMapViewModel.swift
//  PizzaPlaneta
//
//  Created by Jesús Lugo Sáenz on 25/01/25.
//

import UIKit
import MapKit
import CoreLocation

protocol PizzeriaMapViewModelDelegate: AnyObject {
    func updateUserLocation(userLocation: CLLocationCoordinate2D)
    
    func showPizzeriaLocation(location: CLLocationCoordinate2D)
    
    func showDirectionOverlay(overlay:  MKPolyline)
}

class PizzeriaMapViewModel: NSObject {
    private var pizzeriaLocation: PizzaModel.Location
    
    private let locationManager = CLLocationManager()
    
    private(set) var userLocation: CLLocationCoordinate2D?
    
    weak var delegate: PizzeriaMapViewModelDelegate?
    
    init(pizzeriaLocation: PizzaModel.Location) {
        self.pizzeriaLocation = pizzeriaLocation
        super.init()
        initializerForLocationManager()
        locationManager.delegate = self
    }
    
    func initializerForLocationManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest //Indicar que tan específico queremos la ubicación
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func didTapPizzeriaLocationButton() {
        
        let pizzeriaLocation = CLLocationCoordinate2D(latitude: pizzeriaLocation.latitude, longitude: pizzeriaLocation.longitude)
        
        self.delegate?.showPizzeriaLocation(location: pizzeriaLocation)
    }
    
    func didTapShowDirectionsButton() {
        guard let userLocation else { return }
        let directionRequest = MKDirections.Request()
        let pizzeriaLocation = CLLocationCoordinate2D(latitude: pizzeriaLocation.latitude, longitude: pizzeriaLocation.longitude)
        
        directionRequest.source = MKMapItem(placemark: MKPlacemark(coordinate: userLocation))
        directionRequest.destination = MKMapItem(placemark: MKPlacemark(coordinate: pizzeriaLocation))
        
        directionRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionRequest)
        
        directions.calculate { response , error in
            guard error == nil,
                  let response,
                  let route = response.routes.first
            else { return }
            
            self.delegate?.showDirectionOverlay(overlay: route.polyline)
        }
    }
    
}

extension PizzeriaMapViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        userLocation = coordinate
    }
}
