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
class MapViewModel: ObservableObject {
  //
  // MARK: - Variables and Published Properties
  //
  @Published var region = MKCoordinateRegion(center: MapDetails.defaultLocation, span: MapDetails.defaultSpin)
  @Published var locations = Locations.annotations
  
  @Published var errorMessage = ""
  @Published var showAlert = false

  //
  // MARK: - Internal Method
  //
  /// This function check the localization authorization status
  func checkIfLocationIsEnabled() {
    MapManager.shared().checkIfLocationIsEnabled(listener: self)
  }
}

//
// MARK: - Extension Map Listener
//

/// This extension for the MapListener Protocol
extension MapViewModel: MapListener {
  //
  // MARK: - Protocol Methods
  //
  /// Provide error message when the services return one
  func haveError(message: String) {
    self.errorMessage = message
  }
  
  /// Return the user coordinate when he authorize service
  func haveRegion(coordinate: MKCoordinateRegion) {
    self.region = coordinate
  }
}
