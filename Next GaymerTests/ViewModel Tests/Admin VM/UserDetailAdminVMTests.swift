//
//  UserDetailAdminVMTests.swift
//  Next GaymerTests
//
//  Created by Fabien Saint Germain on 16/02/2022.
//

import XCTest
@testable import Next_Gaymer

class UserDetailAdminVMTests: XCTestCase {

  var vm = UserDetailsAdminViewModel(selectedUser: FakePreviewData.fakeSelectedUser)
  
  override func setUp() {
    vm = UserDetailsAdminViewModel(selectedUser: FakePreviewData.fakeSelectedUser)
  }
  
  func testGivenSuccesWhenUpdateUserCredentialThenReturnMessage() {
    
    DataManager._shared = DataManagerInit.success
    XCTAssertTrue(vm.confirmationMessage.isEmpty)
    vm.setUserAdminCrentials()
    XCTAssertTrue(vm.presentAlert)
    XCTAssertFalse(vm.confirmationMessage.isEmpty)
    XCTAssertTrue(vm.requestStatus == .initial)
  }
  
  func testGivenErrorWhenUpdateUserCredentialThenReturnMessage() {
    
    DataManager._shared = DataManagerInit.failed
    XCTAssertTrue(vm.confirmationMessage.isEmpty)
    vm.setUserAdminCrentials()
    XCTAssertTrue(vm.presentAlert)
    XCTAssertFalse(vm.confirmationMessage.isEmpty)
    XCTAssertTrue(vm.requestStatus == .initial)
  }
}
