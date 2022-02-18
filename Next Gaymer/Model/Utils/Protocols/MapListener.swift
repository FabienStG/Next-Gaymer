//
//  MapListenerProtocol.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 15/02/2022.
//

import MapKit

protocol MapListener {
  
  func haveError(message: String)
  func haveRegion(coordinate: MKCoordinateRegion)
  
}
