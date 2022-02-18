//
//  EventDetailVMTests.swift
//  Next GaymerTests
//
//  Created by Fabien Saint Germain on 16/02/2022.
//

import XCTest
@testable import Next_Gaymer

class EventDetailVMTests: XCTestCase {

  var vm = EventDetailViewModel(event: FakeData.eventWithNoRegisters)
  
  override func setUp() {
    vm = EventDetailViewModel(event: FakeData.eventWithNoRegisters)
  }
  
  func testRegistrateUserToEventThenReturnSucces() {
    
    DataManager._shared = DataManagerInit.success
    XCTAssertTrue(vm.requestStatus == .initial)
    vm.registrateUserToEvent(currentUser: FakeData.registeredAdmin)
    
    XCTAssertTrue(vm.disableButton)
    XCTAssertTrue(vm.showAlert)
    XCTAssertFalse(vm.alertMessage.isEmpty)
    XCTAssertTrue(vm.requestStatus == .success)
  }
  
  func testRegistrateUserToEventThenReturnError() {
    
    DataManager._shared = DataManagerInit.failed
    XCTAssertTrue(vm.requestStatus == .initial)
    vm.registrateUserToEvent(currentUser: FakeData.registeredAdmin)
    
    XCTAssertFalse(vm.disableButton)
    XCTAssertTrue(vm.requestStatus == .fail)
    XCTAssertTrue(vm.showAlert)
    XCTAssertFalse(vm.alertMessage.isEmpty)
  }
}
