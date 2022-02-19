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
  //
  // MARK: - Variables and Properties
  //
  var listener: MapListener?
  lazy var locationManager = CLLocationManager()

  //
  // MARK: - Internal Methods
  //
  /// This is the Location manager delegate function
  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    checkLocationAuthorization()
  }
  
  /// This function check if the user enable the localization service
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
  /// This return the message dependly of the authorization status
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
