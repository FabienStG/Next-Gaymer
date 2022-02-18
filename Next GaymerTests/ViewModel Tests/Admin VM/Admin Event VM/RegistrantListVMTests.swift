//
//  RegistrantListVMTests.swift
//  Next GaymerTests
//
//  Created by Fabien Saint Germain on 16/02/2022.
//

import XCTest
@testable import Next_Gaymer

class RegistrantListVMTests: XCTestCase {

  var vm = RegistrantListAdminViewModel()
  
  override func setUp() {
    vm = RegistrantListAdminViewModel()
  }

  func testWhenFetchListThenReturnSuccessAndArray() {
    
    DataManager._shared = DataManagerInit.success
    XCTAssertTrue(vm.registrantList.isEmpty)
    vm.fetchRegistrantList(event: FakePreviewData.fakeOnlineEvent)
    XCTAssertNotNil(vm.registrantList[0])
    XCTAssertFalse(vm.showAlert)
  }
  
  func testWhenFetchListThenReturnErrorAndShowAlert() {
    
    DataManager._shared = DataManagerInit.failed
    XCTAssertTrue(vm.registrantList.isEmpty)
    vm.fetchRegistrantList(event: FakePreviewData.fakeOnlineEvent)
    XCTAssertTrue(vm.registrantList.isEmpty)
    XCTAssertTrue(vm.showAlert)
    XCTAssertFalse(vm.errorMessage.isEmpty)
  }
}
