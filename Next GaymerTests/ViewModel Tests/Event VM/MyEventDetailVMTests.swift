//
//  MyEventDetailVMTests.swift
//  Next GaymerTests
//
//  Created by Fabien Saint Germain on 16/02/2022.
//

import XCTest
@testable import Next_Gaymer

class MyEventDetailVMTests: XCTestCase {
  
  override func setUp() {
    NotificationManagerInit.mockedNotification.didFunctionScheduleCalled = false
    NotificationManagerInit.mockedNotification.didFunctionSetCalled = false
    NotificationManagerInit.mockedNotification.didFunctionRemoveCalled = false
  }

  func testWhenVMInitThenReturnPreferenceAsTrue() {
    
    NotificationManager._shared = NotificationManagerInit.success
    let vm = MyEventDetailViewModel(selectedEvent: FakeData.eventWithRegisters)
    
    XCTAssertTrue(vm.isReminderActive)
  }
  
  func testWhenVMInitThenReturnDefaultPreferenceAsFalse() {
    
    NotificationManager._shared = NotificationManagerInit.failed
    let vm = MyEventDetailViewModel(selectedEvent: FakeData.eventWithRegisters)
    
    XCTAssertFalse(vm.isReminderActive)
  }
  
  func testWhenReminderIsActiveThenRemove() {
    
    NotificationManager._shared = NotificationManagerInit.success
    let vm = MyEventDetailViewModel(selectedEvent: FakeData.eventWithRegisters)
    
    vm.manageReminder()
    XCTAssertTrue(NotificationManagerInit.mockedNotification.didFunctionRemoveCalled)
    XCTAssertFalse(NotificationManagerInit.mockedNotification.didFunctionScheduleCalled)
    XCTAssertTrue(NotificationManagerInit.mockedNotification.didFunctionSetCalled)
  }

  func testWhenReminderIsActiveThenAdd() {
    
    NotificationManager._shared = NotificationManagerInit.success
    let vm = MyEventDetailViewModel(selectedEvent: FakeData.eventWithRegisters)
    vm.isReminderActive = false
    
    vm.manageReminder()
    XCTAssertFalse(NotificationManagerInit.mockedNotification.didFunctionRemoveCalled)
    XCTAssertTrue(NotificationManagerInit.mockedNotification.didFunctionScheduleCalled)
    XCTAssertTrue(NotificationManagerInit.mockedNotification.didFunctionSetCalled)
  }
  
  func testWhenUserRemoveFromEventThenSuccessAndReturnAlert() {
    
    NotificationManager._shared = NotificationManagerInit.success
    DataManager._shared = DataManagerInit.success
    let vm = MyEventDetailViewModel(selectedEvent: FakeData.eventWithRegisters)
    vm.isReminderActive = true
    
    vm.removeUserFromEvent(currentUser: FakeData.registeredAdmin)
    XCTAssertTrue(vm.showAlert)
    XCTAssertFalse(vm.message.isEmpty)
    XCTAssertTrue(vm.requestStatus == .success)
    
    XCTAssertTrue(NotificationManagerInit.mockedNotification.didFunctionRemoveCalled)
    XCTAssertFalse(NotificationManagerInit.mockedNotification.didFunctionScheduleCalled)
    XCTAssertTrue(NotificationManagerInit.mockedNotification.didFunctionSetCalled)
  }
  
  func testWhenUserRemoveFromEventThenError() {
    
    DataManager._shared = DataManagerInit.failed
    let vm = MyEventDetailViewModel(selectedEvent: FakeData.eventWithRegisters)
    vm.isReminderActive = true
    
    vm.removeUserFromEvent(currentUser: FakeData.registeredAdmin)
    XCTAssertTrue(vm.showAlert)
    XCTAssertFalse(vm.message.isEmpty)
    XCTAssertTrue(vm.requestStatus == .fail)
  }
}
