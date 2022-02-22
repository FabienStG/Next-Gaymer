//
//  DataManagerEventTests.swift
//  Next GaymerTests
//
//  Created by Fabien Saint Germain on 14/02/2022.
//

import XCTest
@testable import Next_Gaymer

class DataManagerEventTests: XCTestCase {
  
  let dataManager = DataManager(registrationServices: MockedRegistrationServices(), chatServices: MockedChatServices(),
                                eventServices: MockedEventServices(), adminServices: MockedAdminServices(),
                                userServices: MockedUserServices(), centerServices: MockedCenterServices())
  
  let dataManaderFailed = DataManager(registrationServices: MockedRegistrationServicesFailed(), chatServices: MockedChatServicesFailed(),
                                      eventServices: MockedEventServicesFailed(), adminServices: MockedAdminServicesFailed(),
                                      userServices: MockedUserServicesFailed(), centerServices: MockedCenterServicesFailed())


  func testFetchAllEventsThenReturnEventArray() {
    
    dataManager.fetchAllEvents { events, error in
      XCTAssertNotNil(events)
      XCTAssertEqual(events![0].id, FakeData.eventWithRegisters.id)
      XCTAssertNil(error)
    }
  }
  
  func testFetchAllEventsThenReturnError() {
    
    dataManaderFailed.fetchAllEvents { events, error in
      XCTAssertNil(events)
      XCTAssertNotNil(error)
      XCTAssertEqual(error, "error")
    }
  }
  
  func testFetchMyEventTheReturnEventArray() {
    
    dataManager.fetchMyEvents { events, error in
      XCTAssertNotNil(events)
      XCTAssertEqual(events[0].eventName, FakeData.eventWithNoRegisters.eventName)
      XCTAssertNil(error)
    }
  }
  
  func testFetchMyEventTheReturnEmptyArrayAndError() {
    
    dataManaderFailed.fetchMyEvents { events, error in
      XCTAssertNotNil(events)
      XCTAssertTrue(events.isEmpty)
      XCTAssertEqual(error, "error")
    }
  }
  
  func testRegistrateUserToEventThenReturnSuccess() {
    
    dataManager.registrateUserForEvent(currentUser: FakeData.registeredAdmin, event: FakeData.eventWithNoRegisters) { result, message in
      XCTAssertTrue(result)
      XCTAssertEqual(message, NSLocalizedString("registrateComplete", comment: ""))
    }
  }
  
  func testRegistrateUserToEventThenReturnFailedAlreadyRegistered() {
    
    dataManager.registrateUserForEvent(currentUser: FakeData.registeredAdmin, event: FakeData.eventWithRegisters) { result, message in
      XCTAssertFalse(result)
      XCTAssertEqual(message, NSLocalizedString("alreadyRegistrateEvent", comment: ""))
    }
  }
  
  func testRegistrateUserToEventThenReturnFailedEventFull() {
    
    dataManager.registrateUserForEvent(currentUser: FakeData.registeredUser, event: FakeData.eventWithFullRegisters) { result, message in
      XCTAssertFalse(result)
      XCTAssertEqual(message, NSLocalizedString("eventFull", comment: ""))
    }
  }
  
  func testCancelUserRegistrationToEventThenReturnTrue() {
    
    dataManager.deleteUserFromEvent(currentUser: FakeData.registeredAdmin, event: FakeData.eventWithRegisters) { result, message in
      XCTAssertTrue(result)
      XCTAssertEqual(message, NSLocalizedString("registrationCanceled", comment: ""))
    }
  }
  
  func testCancelUserRegistrationToEventThenReturnFalseAndError() {
    
    dataManaderFailed.deleteUserFromEvent(currentUser: FakeData.registeredAdmin, event: FakeData.eventWithRegisters) { result, message in
      XCTAssertFalse(result)
      XCTAssertEqual(message, "error")
    }
  }
}
