//
//  MapServicesProtocol.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 15/02/2022.
//

import Foundation
//
// MARK: - Map Services Protocol
//

/// This protocol help for the MapKit mocking tests
protocol MapServices {
  
  func checkIfLocationServicesIsEnabled(listener: MapListener)

}
