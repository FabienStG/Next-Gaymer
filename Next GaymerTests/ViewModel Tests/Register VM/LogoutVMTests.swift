//
//  LogoutVMTests.swift
//  Next GaymerTests
//
//  Created by Fabien Saint Germain on 16/02/2022.
//

import XCTest
@testable import Next_Gaymer

class LogoutVMTests: XCTestCase {

  var vm = LogoutViewModel()
  
  override func setUp() {
    vm = LogoutViewModel()
    UserLogStatus.shared.logStatus = false
  }
    
  func testWhenLogoutThenReturnSuccesAndLogout() {
    
    DataManager._shared = DataManagerInit.success
    UserLogStatus.shared.logStatus = true
    vm.logoutUser()
    XCTAssertTrue(vm.requestStatus == .success)
    XCTAssertFalse(UserLogStatus.shared.logStatus)
  }
  
  func testWhenLogoutThenReturnErrorAndShowAlert() {
    
    DataManager._shared = DataManagerInit.failed
    UserLogStatus.shared.logStatus = true
    vm.logoutUser()
    XCTAssertTrue(vm.requestStatus == .fail)
    XCTAssertTrue(UserLogStatus.shared.logStatus)
    XCTAssertTrue(vm.showAlert)
    XCTAssertFalse(vm.errorMessage.isEmpty)
  }
  
}
