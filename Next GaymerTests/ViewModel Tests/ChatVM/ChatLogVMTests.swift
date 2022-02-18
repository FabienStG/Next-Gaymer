//
//  ChatLogVMTests.swift
//  Next GaymerTests
//
//  Created by Fabien Saint Germain on 16/02/2022.
//

import XCTest
@testable import Next_Gaymer

class ChatLogVMTests: XCTestCase {

  var vm = ChatLogViewModel()
  
  override func setUp() {
    vm = ChatLogViewModel()
    DataManagerInit.mockedChat.didFunctionCalled = false
  }
  
  func testDisableButtonThenReturnTrue() {
    
    XCTAssertTrue(vm.disableButton())
  }
  
  func testGivenTextWhenDisableButtonThenReturnFalse() {
    
    vm.chatText = "test"
    XCTAssertFalse(vm.disableButton())
  }
  
  func testWhenFetchMessageThenReturnArray() {
    
    DataManager._shared = DataManagerInit.success
    XCTAssertTrue(vm.chatMessages.isEmpty)
    
    vm.fetchMessages(senderUser: FakeData.registeredAdmin, recipientUser: FakeData.userDetails)
    XCTAssertFalse(vm.chatMessages.isEmpty)
    XCTAssertFalse(vm.showAlert)
    XCTAssertTrue(vm.errorMessage.isEmpty)
  }
  
  func testWhenFetchMessageThenReturnErrorMessageAndAlert() {
    
    DataManager._shared = DataManagerInit.failed
    XCTAssertTrue(vm.chatMessages.isEmpty)
    
    vm.fetchMessages(senderUser: FakeData.registeredAdmin, recipientUser: FakeData.userDetails)
    XCTAssertTrue(vm.chatMessages.isEmpty)
    XCTAssertTrue(vm.showAlert)
    XCTAssertFalse(vm.errorMessage.isEmpty)
  }
  
  func testWhenSaveMessageThenReturnSuccess() {
    
    DataManager._shared = DataManagerInit.success
    vm.chatText = "test"
    
    vm.saveMessage(senderUser: FakeData.registeredAdmin, recipientUser: FakeData.userDetails)
    XCTAssertTrue(vm.chatText.isEmpty)
    XCTAssertFalse(vm.showAlert)
    XCTAssertTrue(vm.errorMessage.isEmpty)
  }
  
  func testWhenSaveMessageThenReturnErrorAndShowAlert() {
    
    DataManager._shared = DataManagerInit.failed
    vm.chatText = "test"
    
    vm.saveMessage(senderUser: FakeData.registeredAdmin, recipientUser: FakeData.userDetails)
    XCTAssertFalse(vm.chatText.isEmpty)
    XCTAssertTrue(vm.showAlert)
    XCTAssertFalse(vm.errorMessage.isEmpty)
  }
  
  func testWhenUserStopListeningThenFunctionIsTriggered() {
    
    DataManager._shared = DataManagerInit.success
    
    vm.stopListening()
    XCTAssertTrue(DataManagerInit.mockedChat.didFunctionCalled)
  }
  
}
