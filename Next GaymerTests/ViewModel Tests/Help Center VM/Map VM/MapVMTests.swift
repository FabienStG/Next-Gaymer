//
//  MapVMTests.swift
//  Next GaymerTests
//
//  Created by Fabien Saint Germain on 16/02/2022.
//

import XCTest
@testable import Next_Gaymer

class MapVMTests: XCTestCase {

  var vm = MapViewModel()
  
  override func setUp() {
    vm = MapViewModel()
  }
  
  func testCheckIfLocationEnabledThenReturnUserLocation() {
    
    MapManager._shared = MapManagerInit.success
    
    vm.checkIfLocationIsEnabled()
    XCTAssertTrue(vm.errorMessage.isEmpty)
    XCTAssertFalse(vm.showAlert)
  }
  
  func testCheckIfLocationEnabledThenReturnErrorMessage() {
    
    MapManager._shared = MapManagerInit.failed
    
    vm.checkIfLocationIsEnabled()
    XCTAssertFalse(vm.errorMessage.isEmpty)
    XCTAssertFalse(vm.showAlert)
  }
}
