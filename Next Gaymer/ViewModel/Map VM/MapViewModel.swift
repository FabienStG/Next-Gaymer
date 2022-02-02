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
      errorMessage = NSLocalizedString("localizeNotAllowed", comment: "")
      showAlert.toggle()
    }
  }
  
 private func checkLocationAuthorization() {
    guard let locationManager = locationManager else { return }
    
    switch locationManager.authorizationStatus {
      
    case .notDetermined:
      locationManager.requestWhenInUseAuthorization()
    case .restricted:
      errorMessage = NSLocalizedString("localizeLimited", comment: "")
      showAlert.toggle()
    case .denied:
      errorMessage = NSLocalizedString("localizeNotAllowed", comment: "")
      showAlert.toggle()
    case .authorizedAlways, .authorizedWhenInUse:
      region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MapDetails.zoomedSpin)
    @unknown default:
      errorMessage = NSLocalizedString("unknownError", comment: "")
      showAlert.toggle()
      break
    }
  }
  
  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    checkLocationAuthorization()
  }
}
