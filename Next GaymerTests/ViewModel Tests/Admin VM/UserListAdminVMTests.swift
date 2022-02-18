//
//  UserListAdminVMTests.swift
//  Next GaymerTests
//
//  Created by Fabien Saint Germain on 16/02/2022.
//

import XCTest
@testable import Next_Gaymer

class UserListAdminVMTests: XCTestCase {

  func testWhenVMInitAndFetchThenReturnSuccessAndArray() {
    
    DataManager._shared = DataManagerInit.success
    let vm = UserListAdminViewModel()
    XCTAssertFalse(vm.userList.isEmpty)
    XCTAssertFalse(vm.showAlert)
    XCTAssertTrue(vm.errorMessage.isEmpty)
  }
  
  func testwhenVMInitAndFetchReturnErrorndMessage() {
    
    DataManager._shared = DataManagerInit.failed
    let vm = UserListAdminViewModel()
    XCTAssertTrue(vm.userList.isEmpty)
    XCTAssertTrue(vm.showAlert)
    XCTAssertFalse(vm.errorMessage.isEmpty)
  }
}
