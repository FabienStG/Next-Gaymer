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
class MapViewModel: ObservableObject, MapListener {
  func haveError(message: String) {
    self.errorMessage = message
  }
  
  func haveRegion(coordinate: MKCoordinateRegion) {
    self.region = coordinate
  }
  
  //
  // MARK: - Variables and Published Properties

  
  @Published var region = MKCoordinateRegion(center: MapDetails.defaultLocation, span: MapDetails.defaultSpin)
  @Published var locations = Locations.annotations
  
  @Published var errorMessage = ""
  @Published var showAlert = false

  //
  // MARK: - Internal Method
  func checkIfLocationIsEnabled() {
    MapManager.shared().checkIfLocationIsEnabled(listener: self)
  }
}
