//
//  EventRegistrationVMTests.swift
//  Next GaymerTests
//
//  Created by Fabien Saint Germain on 16/02/2022.
//

import XCTest
@testable import Next_Gaymer

class EventRegistrationVMTests: XCTestCase {

  var vm = EventRegisterAdminViewModel()
  
  override func setUp() {
    vm = EventRegisterAdminViewModel()
  }
  
  func testCreateEventThenReturnSuccess() {
    
    DataManager._shared = DataManagerInit.success
    
    XCTAssertTrue(vm.requestStatus == .initial)
    vm.registrateEvent()
    XCTAssertTrue(vm.requestStatus == .success)
  }
  
  func testCreateEventThenReturnFailAndErrorMessage() {
    
    DataManager._shared = DataManagerInit.failed
    
    XCTAssertTrue(vm.requestStatus == .initial)
    vm.registrateEvent()
    XCTAssertTrue(vm.requestStatus == .fail)
    XCTAssertTrue(vm.showAlert)
    XCTAssertFalse(vm.alertMessage.isEmpty)
  }
}
