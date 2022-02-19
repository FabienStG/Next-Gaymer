//
//  MapListenerProtocol.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 15/02/2022.
//

import MapKit
//
// MARK: - Map Listener Protocol
//

/// This protocol listen any change in localization authorization and advise the viewModel
protocol MapListener {
  
  func haveError(message: String)
  func haveRegion(coordinate: MKCoordinateRegion)
  
}
