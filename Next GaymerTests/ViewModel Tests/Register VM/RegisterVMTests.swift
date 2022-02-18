//
//  RegisterVMTests.swift
//  Next GaymerTests
//
//  Created by Fabien Saint Germain on 16/02/2022.
//

import XCTest
@testable import Next_Gaymer

class RegisterVMTests: XCTestCase {

  var vm = RegisterViewModel()
  
  override func setUp() {
    vm = RegisterViewModel()
    UserLogStatus.shared.logStatus = false
  }
    
  func testGivenFulFormWhenRegisterUserThenReturnSuccesAndLogin() {
    
    DataManager._shared = DataManagerInit.success
    ViewModelsInit.registerProvideForm(vm)
    XCTAssertTrue(vm.requestStatus == .initial)
    vm.registerUserButton()
    XCTAssertTrue(vm.requestStatus == .success)
    XCTAssertTrue(UserLogStatus.shared.logStatus)
  }
  
  func testGivenFullFormWhenRegisterUserThenReturnError() {
    
    DataManager._shared = DataManagerInit.failed
    ViewModelsInit.registerProvideForm(vm)
    XCTAssertTrue(vm.requestStatus == .initial)
    vm.registerUserButton()
    XCTAssertTrue(vm.requestStatus == .fail)
    XCTAssertFalse(UserLogStatus.shared.logStatus)
    XCTAssertFalse(vm.errorMessage.isEmpty)
    XCTAssertTrue(vm.showAlert)
  }
  
  func testGivenEmptyFormWhenRegisterUserThenReturnError() {
    
    DataManager._shared = DataManagerInit.success
    XCTAssertTrue(vm.requestStatus == .initial)
    vm.registerUserButton()
    XCTAssertTrue(vm.showAlert)
    XCTAssertEqual(vm.errorMessage, NSLocalizedString("emptyForm", comment: ""))
  }
  
  func testGivenEmptyFormThenButtonDisabled() {
    
    XCTAssertFalse(vm.disableButton())
  }
  
  func testGivenFullFormThenButtonEnabled() {
    
    ViewModelsInit.registerProvideForm(vm)
    XCTAssertTrue(vm.disableButton())
  }
}
