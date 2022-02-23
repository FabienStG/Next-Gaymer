//
//  HelpPageVMTests.swift
//  Next GaymerTests
//
//  Created by Fabien Saint Germain on 22/02/2022.
//

import XCTest
@testable import Next_Gaymer

class HelpPageVMTests: XCTestCase {

  func testWhenVMInitThenReturnArray() {
    
    DataManager._shared = DataManagerInit.success
    let vm = HelpPageViewModel()
    XCTAssertFalse(vm.helpCenters.isEmpty)
  }
  
  func testWhenVMInitThenFailedAndReturnEmptyArray() {
    
    DataManager._shared = DataManagerInit.failed
    let vm = HelpPageViewModel()
    XCTAssertTrue(vm.helpCenters.isEmpty)
  }
}
