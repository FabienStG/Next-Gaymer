//
//  MapViewModel.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 26/01/2022.
//

import MapKit

class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
  
  @Published var region = MKCoordinateRegion(center: MapDetails.defaultLocation, span: MapDetails.defaultSpin)
  @Published var locations = Locations.annotations
    
  @Published var errorMessage = ""
  @Published var showAlert = false

  var locationManager: CLLocationManager?
  
  func checkIfLocationServicesIsEnabled() {
    if CLLocationManager.locationServicesEnabled() {
      locationManager = CLLocationManager()
      locationManager?.desiredAccuracy = kCLLocationAccuracyBest
      locationManager!.delegate = self
    } else {
      errorMessage = "Vous n'avez pas autorisé les services de localisation."
      showAlert.toggle()
    }
  }
  
 private func checkLocationAuthorization() {
    guard let locationManager = locationManager else { return }
    
    switch locationManager.authorizationStatus {
      
    case .notDetermined:
      locationManager.requestWhenInUseAuthorization()
    case .restricted:
      errorMessage = "Les services de localisation ont été limités."
      showAlert.toggle()
    case .denied:
      errorMessage = "Vous n'avez pas autorisé les services de localisation"
      showAlert.toggle()
    case .authorizedAlways, .authorizedWhenInUse:
      region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MapDetails.zoomedSpin)
    @unknown default:
      errorMessage = "Erreur inconnue."
      showAlert.toggle()
      break
    }
  }
  
  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    checkLocationAuthorization()
  }
}
