//
//  ProfileVMTests.swift
//  Next GaymerTests
//
//  Created by Fabien Saint Germain on 16/02/2022.
//

import XCTest
@testable import Next_Gaymer

class ProfileVMTests: XCTestCase {

  var vm = ProfileViewModel()
  
  override func setUp() {
    vm = ProfileViewModel()
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
  
  func testModifyProfileThenPublishedAreChanged() {
    
    XCTAssertTrue(vm.name.isEmpty)
    vm.modifyProfile(user: FakeData.registeredAdmin)
    XCTAssertEqual(vm.name, FakeData.registeredAdmin.name)
  }
  
  func testUpdateUserInfoThenReturnTrueAndSuccessMessage() {
    
    DataManager._shared = DataManagerInit.success
    vm.modifyProfile(user: FakeData.registeredAdmin)
    vm.validateModifications()
    XCTAssertTrue(vm.updateComplete)
    XCTAssertTrue(vm.disableModification)
    XCTAssertTrue(vm.showAlert)
    XCTAssertEqual(vm.errorMessage, NSLocalizedString("modificationComplete", comment: ""))
  }
  
  func testUpdateUserInfoThenReturnFalseAndShowAlert() {
    
    DataManager._shared =  DataManagerInit.failed
    vm.modifyProfile(user: FakeData.registeredAdmin)
    vm.validateModifications()
    XCTAssertFalse(vm.updateComplete)
    XCTAssertFalse(vm.disableModification)
    XCTAssertTrue(vm.showAlert)
    XCTAssertEqual(vm.errorMessage, "error")
  }
}
