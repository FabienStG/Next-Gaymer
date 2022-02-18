//
//  CurrentUserVMTests.swift
//  Next GaymerTests
//
//  Created by Fabien Saint Germain on 16/02/2022.
//

import XCTest
@testable import Next_Gaymer

class CurrentUserVMTests: XCTestCase {

  func testGivenUserThenModelReturnUser() {
    
    DataManager._shared = DataManagerInit.success
    
    let vm = CurrentUserViewModel()
    XCTAssertNotNil(vm.currentUser)
    XCTAssertFalse(vm.showAlert)
    XCTAssertTrue(vm.errorMessage.isEmpty)
  }
  
  func testGivenErrorThenModelReturnErrorAndShowAlert() {
    
    DataManager._shared = DataManagerInit.failed
    
    let vm = CurrentUserViewModel()
    XCTAssertNil(vm.currentUser)
    XCTAssertTrue(vm.showAlert)
    XCTAssertFalse(vm.errorMessage.isEmpty)
  }
}
