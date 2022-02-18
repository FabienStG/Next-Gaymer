//
//  GoogleRegisterVMTests.swift
//  Next GaymerTests
//
//  Created by Fabien Saint Germain on 16/02/2022.
//

import XCTest
@testable import Next_Gaymer

class GoogleRegisterVMTests: XCTestCase {
  
  override func setUp() {
    UserLogStatus.shared.logStatus = false
  }
  
  func testWhenVMInitThenReturnUserAndProvideForm() {
    
    DataManager._shared = DataManagerInit.success
    
    let vm = GoogleRegisterViewModel()
    XCTAssertFalse(vm.email.isEmpty)
  }
  
  func testGivenFulFormWhenRegisterUserThenReturnSuccesAndLogin() {
    
    DataManager._shared = DataManagerInit.success
    let vm = GoogleRegisterViewModel()
    
    ViewModelsInit.googleProvideForm(vm)
    XCTAssertTrue(vm.requestStatus == .initial)
    vm.registerUserButton()
    XCTAssertTrue(vm.requestStatus == .success)
    XCTAssertTrue(UserLogStatus.shared.logStatus)
  }
  
  func testGivenFullFormWhenRegisterUserThenReturnError() {
    
    DataManager._shared = DataManagerInit.failed
    let vm = GoogleRegisterViewModel()
    
    ViewModelsInit.googleProvideForm(vm)
    XCTAssertTrue(vm.requestStatus == .initial)
    vm.registerUserButton()
    XCTAssertTrue(vm.requestStatus == .fail)
    XCTAssertFalse(UserLogStatus.shared.logStatus)
    XCTAssertFalse(vm.errorMessage.isEmpty)
    XCTAssertTrue(vm.showAlert)
  }
  
  func testGivenEmptyFormWhenRegisterUserThenReturnError() {
    
    DataManager._shared = DataManagerInit.success
    let vm = GoogleRegisterViewModel()
    
    XCTAssertTrue(vm.requestStatus == .initial)
    vm.registerUserButton()
    XCTAssertTrue(vm.showAlert)
    XCTAssertEqual(vm.errorMessage, NSLocalizedString("emptyForm", comment: ""))
  }
  
  func testGivenEmptyFormThenButtonDisabled() {
    DataManager._shared = DataManagerInit.success
    let vm = GoogleRegisterViewModel()
    
    XCTAssertFalse(vm.disableButton())
  }
  
  func testGivenFullFormThenButtonEnabled() {
    DataManager._shared = DataManagerInit.success
    let vm = GoogleRegisterViewModel()
    
    ViewModelsInit.googleProvideForm(vm)
    XCTAssertTrue(vm.disableButton())
  }
}
