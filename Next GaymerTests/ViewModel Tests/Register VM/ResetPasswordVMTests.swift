//
//  ResetPasswordVMTests.swift
//  Next GaymerTests
//
//  Created by Fabien Saint Germain on 16/02/2022.
//

import XCTest
@testable import Next_Gaymer

class ResetPasswordVMTests: XCTestCase {
  
  var vm = ResetPasswordViewModel()
  
  override func setUp() {
    vm = ResetPasswordViewModel()
  }
  
  func testResetPasswordThenSuccess() {
    
    DataManager._shared = DataManagerInit.success
    
    XCTAssertTrue(vm.requestStatus == .initial)
    vm.resetPassword()
    XCTAssertTrue(vm.requestStatus == .initial)
    XCTAssertFalse(vm.showAlert)
    XCTAssertTrue(vm.errorMessage.isEmpty)
  }
  
  func testResetPasswordThenShowAlert() {
    
    DataManager._shared = DataManagerInit.failed
    
    XCTAssertTrue(vm.requestStatus == .initial)
    vm.resetPassword()
    XCTAssertTrue(vm.requestStatus == .initial)
    XCTAssertTrue(vm.showAlert)
    XCTAssertFalse(vm.errorMessage.isEmpty)
  }
}
