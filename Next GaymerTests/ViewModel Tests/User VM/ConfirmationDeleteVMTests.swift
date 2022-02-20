//
//  ConfirmationDeleteVMTests.swift
//  Next GaymerTests
//
//  Created by Fabien Saint Germain on 20/02/2022.
//

import XCTest
@testable import Next_Gaymer

class ConfirmationDeleteVMTests: XCTestCase {
  
  var vm = ConfirmationDeleteViewModel()
  
  override func setUp() {
    vm = ConfirmationDeleteViewModel()
    UserLogStatus.shared.logStatus = false
  }
  
  func testDeleteUserThenReturnSuccessAndLogout() {
    
    DataManager._shared = DataManagerInit.success
    UserLogStatus.shared.logStatus = true
    
    vm.reauthenticateUser()
    XCTAssertTrue(vm.requestStatus == .success)
    XCTAssertFalse(UserLogStatus.shared.logStatus)
    XCTAssertFalse(vm.showAlert)
    XCTAssertTrue(vm.errorMessage.isEmpty)
  }
  
  func testDeleteUserThenReturnFail() {
    
    DataManager._shared = DataManagerInit.failed
    UserLogStatus.shared.logStatus = true
    
    vm.reauthenticateUser()
    XCTAssertTrue(UserLogStatus.shared.logStatus)
    XCTAssertTrue(vm.requestStatus == .fail)
    XCTAssertTrue(vm.showAlert)
    XCTAssertFalse(vm.errorMessage.isEmpty)
  }
}
