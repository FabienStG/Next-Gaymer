//
//  MainMessageVMTests.swift
//  Next GaymerTests
//
//  Created by Fabien Saint Germain on 16/02/2022.
//

import XCTest
@testable import Next_Gaymer

class MainMessageVMTests: XCTestCase {

  var vm = MainMessageViewModel()
  
  override func setUp() {
    vm = MainMessageViewModel()
    DataManagerInit.mockedChat.didFunctionCalled = false
  }
  
  func testWhenFetchRecentMessageThenReturnArray() {
    
    DataManager._shared = DataManagerInit.success
    XCTAssertTrue(vm.recentMessages.isEmpty)
    
    vm.fetchRecentMessages()
    XCTAssertFalse(vm.recentMessages.isEmpty)
    XCTAssertFalse(vm.showAlert)
    XCTAssertTrue(vm.errorMessage.isEmpty)
  }
  
  func testGivenMessageWhenFetchRecentMessageThenDeleteOldOne() {
    
    DataManager._shared = DataManagerInit.success
    XCTAssertTrue(vm.recentMessages.isEmpty)
    vm.recentMessages.append(FakeData.recentMessage)
    XCTAssertTrue(vm.recentMessages.count == 1)
    
    vm.fetchRecentMessages()
    XCTAssertFalse(vm.recentMessages.isEmpty)
    XCTAssertTrue(vm.recentMessages.count == 1)
    XCTAssertFalse(vm.showAlert)
    XCTAssertTrue(vm.errorMessage.isEmpty)
  }
  
  func testWhenFetchRentMessageThenReturnError() {
    
    DataManager._shared = DataManagerInit.failed
    XCTAssertTrue(vm.recentMessages.isEmpty)
    
    vm.fetchRecentMessages()
    XCTAssertTrue(vm.recentMessages.isEmpty)
    XCTAssertTrue(vm.showAlert)
    XCTAssertFalse(vm.errorMessage.isEmpty)
  }
  
  func testFetchSelectedUserThenReturnUserAndShowLog() {
    
    DataManager._shared = DataManagerInit.success
    XCTAssertNil(vm.selectedUser)
    
    vm.fetchSelectedUser(currentUser: FakeData.registeredAdmin, messageSelected: FakeData.recentMessage)
    XCTAssertNotNil(vm.selectedUser)
    XCTAssertTrue(vm.isShowingLogchat)
    XCTAssertFalse(vm.showAlert)
    XCTAssertTrue(vm.errorMessage.isEmpty)
  }
  
  func testFetchSelectedUSerThenReturnErrorAndShowAlert() {
    
    DataManager._shared = DataManagerInit.failed
    XCTAssertNil(vm.selectedUser)
    
    vm.fetchSelectedUser(currentUser: FakeData.registeredAdmin, messageSelected: FakeData.recentMessage)
    XCTAssertNil(vm.selectedUser)
    XCTAssertFalse(vm.isShowingLogchat)
    XCTAssertTrue(vm.showAlert)
    XCTAssertFalse(vm.errorMessage.isEmpty)
  }
  
  func testWhenStopListeningThenTriggerAction() {
    
    DataManager._shared = DataManagerInit.success
    XCTAssertFalse(DataManagerInit.mockedChat.didFunctionCalled)
    
    vm.stopListening()
    XCTAssertTrue(DataManagerInit.mockedChat.didFunctionCalled)
  }
  
  func testDeleteMessageThenFuncIsCalled() {
    
    DataManager._shared = DataManagerInit.success
    XCTAssertFalse(DataManagerInit.mockedChat.didFunctionCalled)
    vm.fetchRecentMessages()
    DataManagerInit.mockedChat.didFunctionCalled = false
    
    vm.deleteRecentMessage(with: IndexSet(integer: 0))
    XCTAssertTrue(DataManagerInit.mockedChat.didFunctionCalled)
  }
}
