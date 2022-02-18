//
//  MockedMapServices.swift
//  Next GaymerTests
//
//  Created by Fabien Saint Germain on 16/02/2022.
//

import MapKit
@testable import Next_Gaymer

class MockedMapServices: MapServices {
  
  func checkIfLocationServicesIsEnabled(listener: MapListener) {
    return listener.haveRegion(coordinate: MKCoordinateRegion(center: FakeData.userLocation, span: FakeData.userSpin))
  }
}

class MockedMapServicesFailed: MapServices {
  
  func checkIfLocationServicesIsEnabled(listener: MapListener) {
    return listener.haveError(message: "error")
  }
}
