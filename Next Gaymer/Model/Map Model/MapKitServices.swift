//
//  MapServices.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 07/02/2022.
//

import MapKit
//
// MARK: - MapKit Services
//

/// This class manage the MapKit services and authorisations
class MapKitServices: NSObject, CLLocationManagerDelegate, MapServices {

  lazy var locationManager = CLLocationManager()
  var listener: MapListener?
  
  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    checkLocationAuthorization()
  }
  
  func checkIfLocationServicesIsEnabled(listener: MapListener) {
    self.listener = listener
    if CLLocationManager.locationServicesEnabled() {
      locationManager.desiredAccuracy = kCLLocationAccuracyBest
      locationManager.delegate = self
    } else {
      listener.haveError(message: NSLocalizedString("localizeNotAllowed", comment: ""))
    }
  }
  
  //
  // MARK: - Private Method
  //
  private func checkLocationAuthorization() {

    switch locationManager.authorizationStatus {
    case .notDetermined:
      locationManager.requestWhenInUseAuthorization()
    case .restricted:
      listener!.haveError(message: NSLocalizedString("localizeLimited", comment: ""))
    case .denied:
      listener!.haveError(message: NSLocalizedString("localizeNotAllowed", comment: ""))
    case .authorizedAlways, .authorizedWhenInUse:
      listener!.haveRegion(coordinate: MKCoordinateRegion(center: locationManager.location!.coordinate, span: MapDetails.zoomedSpin))
    @unknown default:
      listener!.haveError(message: NSLocalizedString("unknownError", comment: ""))
    }
  }
}
