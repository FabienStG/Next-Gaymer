//
//  LoginVMTests.swift
//  Next GaymerTests
//
//  Created by Fabien Saint Germain on 16/02/2022.
//

import XCTest
@testable import Next_Gaymer

class LoginVMTests: XCTestCase {
  
  var vm = LoginViewModel()
  
  override func setUp() {
    vm = LoginViewModel()
  }
  
  func testGivenUserThenWhenUserLoginReturnTrueAndLogin() {
    
    DataManager._shared = DataManagerInit.success

    XCTAssertTrue(vm.requestStatus == .initial)
    vm.loginUser()
    XCTAssertTrue(vm.requestStatus == .success)
    XCTAssertFalse(vm.showAlert)
  }
  
  func testLoginReturnErrorAndFail() {
    
    DataManager._shared = DataManagerInit.failed
    
    XCTAssertTrue(vm.requestStatus == .initial )
    vm.loginUser()
    XCTAssertTrue(vm.requestStatus == .fail)
    XCTAssertTrue(vm.showAlert)
    XCTAssertFalse(vm.errorMessage.isEmpty)
  }
  
  func testGivenUserWhenGoogleLoginReturnSuccess() {
    
    DataManager._shared = DataManagerInit.success
    
    XCTAssertTrue(vm.requestStatus == .initial)
    vm.googleLoginUser()
    XCTAssertTrue(vm.requestStatus == .success)
    XCTAssertFalse(vm.showAlert)
    XCTAssertFalse(vm.showGoogleForm)
    XCTAssertTrue(vm.errorMessage.isEmpty)
  }
  
  func testGoogleLoginReturnErrorAndShowAlert() {
    
    DataManager._shared = DataManagerInit.failed
    
    XCTAssertTrue(vm.requestStatus == .initial)
    vm.googleLoginUser()
    XCTAssertTrue(vm.requestStatus == .fail)
    XCTAssertTrue(vm.showAlert)
    XCTAssertFalse(vm.errorMessage.isEmpty)
    XCTAssertFalse(vm.showGoogleForm)
  }
}
