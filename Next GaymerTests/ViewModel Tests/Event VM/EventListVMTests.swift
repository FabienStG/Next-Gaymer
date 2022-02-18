//
//  EventListVMTests.swift
//  Next GaymerTests
//
//  Created by Fabien Saint Germain on 16/02/2022.
//

import XCTest
@testable import Next_Gaymer

class EventListVMTests: XCTestCase {

  func testWhenVMInitThenFetchEventSuccesAndReturnArray() {
    
    DataManager._shared = DataManagerInit.success
    let vm = EventListViewModel()
    XCTAssertFalse(vm.eventList.isEmpty)
    XCTAssertTrue(vm.errorMessage.isEmpty)
    XCTAssertFalse(vm.showAlert)
  }
  
  func testWhenVMInitThenFetchEventErrorAndReturnMessage() {
    
    DataManager._shared = DataManagerInit.failed
    let vm = EventListViewModel()
    XCTAssertTrue(vm.eventList.isEmpty)
    XCTAssertFalse(vm.errorMessage.isEmpty)
    XCTAssertTrue(vm.showAlert)
  }
}
