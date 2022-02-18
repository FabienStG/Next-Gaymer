//
//  AdminListUserVMTests.swift
//  Next GaymerTests
//
//  Created by Fabien Saint Germain on 16/02/2022.
//

import XCTest
@testable import Next_Gaymer

class AdminListUserVMTests: XCTestCase {

  func testWhenVMInitThenReturnAdminArray() {
    
    DataManager._shared = DataManagerInit.success
    let vm = AdminListUserViewModel()
    
    XCTAssertFalse(vm.adminList.isEmpty)
    XCTAssertTrue(vm.errorMessage.isEmpty)
    XCTAssertFalse(vm.showAlert)
  }
  
  func testWhenVMInitThenReturnErrorAndAlert() {
    
    DataManager._shared = DataManagerInit.failed
    let vm = AdminListUserViewModel()
    
    XCTAssertTrue(vm.adminList.isEmpty)
    XCTAssertFalse(vm.errorMessage.isEmpty)
    XCTAssertTrue(vm.showAlert)
  }
}
