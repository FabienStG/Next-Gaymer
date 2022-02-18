//
//  MyEventListVMTests.swift
//  Next GaymerTests
//
//  Created by Fabien Saint Germain on 16/02/2022.
//

import XCTest
@testable import Next_Gaymer

class MyEventListVMTests: XCTestCase {

  func testWhenVMInitThenFetchEventSuccesAndReturnArray() {
    
    DataManager._shared = DataManagerInit.success
    let vm = MyEventListViewModel()
    XCTAssertFalse(vm.eventList.isEmpty)
    XCTAssertTrue(vm.errorMessage.isEmpty)
    XCTAssertFalse(vm.showAlert)
  }
  
  func testWhenVMInitThenFetchEventErrorAndReturnMessage() {
    
    DataManager._shared = DataManagerInit.failed
    let vm = MyEventListViewModel()
    XCTAssertTrue(vm.eventList.isEmpty)
    XCTAssertFalse(vm.errorMessage.isEmpty)
    XCTAssertTrue(vm.showAlert)
  }
}


