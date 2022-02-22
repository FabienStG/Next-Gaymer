//
//  MockedCenterServices.swift
//  Next GaymerTests
//
//  Created by Fabien Saint Germain on 22/02/2022.
//

import Foundation
@testable import Next_Gaymer

class MockedCenterServices: CenterServices {
  
  func fetchCenterList(completionHandler: @escaping ([CenterRegistered]) -> Void) {
    return completionHandler(FakeData.centerArray)
  }
}

class MockedCenterServicesFailed: CenterServices {
  
  func fetchCenterList(completionHandler: @escaping ([CenterRegistered]) -> Void) {
    return completionHandler([])
  }
}
