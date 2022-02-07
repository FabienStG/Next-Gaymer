//
//  MapServices.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 07/02/2022.
//

import MapKit
//
// MARK: - Map Services
//

/// This class manage the MapKit services and authorisations
/*class MapServices: NSObject, CLLocationManagerDelegate {
  var region = MKCoordinateRegion(center: MapDetails.defaultLocation, span: MapDetails.defaultSpin)
  
  var locationManager: CLLocationManager?
  
  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) -> (MKCoordinateRegion, (Bool, String?)) {
    return(region, checkLocationAuthorization())
  }
  
  func checkIfLocationServicesIsEnabled() -> (Bool, String?){
    if CLLocationManager.locationServicesEnabled() {
      locationManager = CLLocationManager()
      locationManager?.desiredAccuracy = kCLLocationAccuracyBest
      locationManager!.delegate = self
      return (true, nil)
    } else {
      return (false, NSLocalizedString("localizeNotAllowed", comment: ""))
    }
  }
  
  //
  // MARK: - Private Method
  //
  private func checkLocationAuthorization() -> (Bool, String?) {
    
    guard let locationManager = locationManager else {
      return (false, NSLocalizedString("unkownError", comment: ""))
    }
    switch locationManager.authorizationStatus {
    case .notDetermined:
      locationManager.requestWhenInUseAuthorization()
    case .restricted:
      return (false, NSLocalizedString("localizeLimited", comment: ""))
    case .denied:
      return (false, NSLocalizedString("localizeNotAllowed", comment: ""))
    case .authorizedAlways, .authorizedWhenInUse:
      region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MapDetails.zoomedSpin)
    @unknown default:
      return (false, NSLocalizedString("unknownError", comment: ""))
    }
    return (false, NSLocalizedString("unknownError", comment: ""))
  }
}

*/
