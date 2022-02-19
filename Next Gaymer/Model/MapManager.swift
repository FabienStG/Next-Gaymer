//
//  MapManager.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 15/02/2022.
//

import Foundation
//
// MARK: - Map Manager
//
/// This class manage the mapkit services
class MapManager {
  //
  // MARK: - Singleton
  //
  static var _shared: MapManager?
  
  //
  // MARK: - Private Properties
  //
  private let mapServices: MapServices
  
  //
  // MARK: - Initialization
  //
  init(mapServices: MapServices) {
    
    self.mapServices = mapServices
  }
  
  //
  // MARK: - Class Methods
  //
  /// Initialize the class
  static func initialized(mapServices: MapServices) {
    _shared = MapManager(mapServices: mapServices)
  }
  
  /// Unwrapp the singleton
  static func shared() -> MapManager {
    return _shared!
  }
  
  //
  // MARK: - Internal Method
  //
  //
  /// Check with the service if the user as enable the localization service
  func checkIfLocationIsEnabled(listener: MapListener) {
    mapServices.checkIfLocationServicesIsEnabled(listener: listener)
  }
}

