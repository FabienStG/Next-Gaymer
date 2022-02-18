//
//  MapManager.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 15/02/2022.
//

import Foundation

class MapManager {
  
  static var _shared: MapManager?
  
  private let mapServices: MapServices
  
  init(mapServices: MapServices) {
    
    self.mapServices = mapServices
  }
  
  static func initialized(mapServices: MapServices) {
    _shared = MapManager(mapServices: mapServices)
  }
  
  static func shared() -> MapManager {
    return _shared!
  }
  
  func checkIfLocationIsEnabled(listener: MapListener) {
    mapServices.checkIfLocationServicesIsEnabled(listener: listener)
  }
}

