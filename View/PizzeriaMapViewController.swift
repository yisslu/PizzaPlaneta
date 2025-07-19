//
//  PizzeriaMapViewController.swift
//  PizzaPlaneta
//
//  Created by Jesús Lugo Sáenz on 25/01/25.
//

import UIKit
import MapKit
import CoreLocation

class PizzeriaMapViewController: UIViewController {
    
    private let viewModel: PizzeriaMapViewModel
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.preferredConfiguration = MKHybridMapConfiguration()
        mapView.showsUserLocation = true
        return mapView
    }()
    
    private lazy var dismissButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        var configuration = UIButton.Configuration.borderedProminent()
        configuration.baseBackgroundColor = .red
        configuration.title = "Dismiss"
        button.configuration = configuration
        
        button.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
        return button
    }()
    
    private lazy var showPizzeriaLocation: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        var configuration = UIButton.Configuration.borderedProminent()
        configuration.title = "Show pizzeria Location"
        configuration.baseBackgroundColor = .red
        button.configuration = configuration
        
        button.addTarget(self, action: #selector(didTapShowPizzeriaButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var showDirectionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        var configuration = UIButton.Configuration.borderedProminent()
        configuration.baseBackgroundColor = .red
        configuration.title = "Show directions to pizzeria"
        button.configuration = configuration
        
        button.addTarget(self, action: #selector(didTapShowDirectionButton), for: .touchUpInside)
        return button
    }()
    
    init(pizzeriaLocation: PizzaModel.Location){
        viewModel = PizzeriaMapViewModel(pizzeriaLocation: pizzeriaLocation)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        mapView.delegate = self
        setupView()
    }
    

    func setupView() {
        view.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        view.addSubview(dismissButton)
        
        NSLayoutConstraint.activate([
            dismissButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 8),
            dismissButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -8)
        ])
        
        view.addSubview(showPizzeriaLocation)
        view.addSubview(showDirectionButton)
        NSLayoutConstraint.activate([
            showPizzeriaLocation.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            showPizzeriaLocation.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            showDirectionButton.bottomAnchor.constraint(equalTo: showPizzeriaLocation.topAnchor, constant: -16),
            showDirectionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        
    }
    
    @objc func dismissViewController(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func didTapShowPizzeriaButton() {
        viewModel.didTapPizzeriaLocationButton()
    }
    
    @objc func  didTapShowDirectionButton() {
        viewModel.didTapShowDirectionsButton()
    }

}


//MARK: - PizzeriaMapViewModelDelegate

extension PizzeriaMapViewController: PizzeriaMapViewModelDelegate {
    func updateUserLocation(userLocation: CLLocationCoordinate2D) {
        let userAnnotation = MKPointAnnotation()
        userAnnotation.coordinate = userLocation
        mapView.addAnnotation(userAnnotation)
        
        let mapRegion = MKCoordinateRegion(center: userLocation, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        mapView.region = mapRegion
    }
    
    func showPizzeriaLocation(location: CLLocationCoordinate2D) {
        let userAnnotation = MKPointAnnotation()
        userAnnotation.coordinate = location
        mapView.addAnnotation(userAnnotation)
        
        let mapRegion = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        mapView.region = mapRegion
    }
    
    func showDirectionOverlay(overlay: MKPolyline) {
        mapView.addOverlay(overlay)
    }
}

//MARK: - MapKit Delegate

extension PizzeriaMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
        
        annotationView.backgroundColor = .white
        annotationView.image = UIImage(systemName: "storefront.fill")
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: any MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .cyan
        renderer.lineWidth = 8
        return renderer
    }
}

