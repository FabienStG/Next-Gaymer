//
//  MapViewModel.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 26/01/2022.
//

import MapKit
//
// MARK: - Map VM
//

/// This class manage the location credential and show the locations
class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
  //
  // MARK: - Variables and Published Properties
  var locationManager: CLLocationManager?
  
  @Published var region = MKCoordinateRegion(center: MapDetails.defaultLocation, span: MapDetails.defaultSpin)
  @Published var locations = Locations.annotations
  @Published var errorMessage = ""
  @Published var showAlert = false

  //
  // MARK: - Internal Method
  //
  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    checkLocationAuthorization()
  }
  
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
  
  //
  // MARK: - Private Method
  //
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
}
