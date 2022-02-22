//
//  DataManagerAdminTests.swift
//  Next GaymerTests
//
//  Created by Fabien Saint Germain on 14/02/2022.
//

import XCTest
@testable import Next_Gaymer

class DataManagerAdminTests: XCTestCase {
  
  let dataManager = DataManager(registrationServices: MockedRegistrationServices(), chatServices: MockedChatServices(),
                                eventServices: MockedEventServices(), adminServices: MockedAdminServices(),
                                userServices: MockedUserServices(), centerServices: MockedCenterServices())
  
  let dataManagerFailed = DataManager(registrationServices: MockedRegistrationServicesFailed(), chatServices: MockedChatServicesFailed(),
                                      eventServices: MockedEventServicesFailed(), adminServices: MockedAdminServicesFailed(),
                                      userServices: MockedUserServicesFailed(), centerServices: MockedCenterServicesFailed())

  
  func testCreateEventThenReturnSuccessBool() {
    
    dataManager.createEvent(event: FakeData.eventForm, image: FakeData.uiImage!) { response, error in
      XCTAssertTrue(response)
      XCTAssertNil(error)
    }
  }
  
  func testCreateEventThenReturnFailBoolAndErrorResponse() {
    
    dataManagerFailed.createEvent(event: FakeData.eventForm, image: FakeData.uiImage!) { response, error in
      XCTAssertFalse(response)
      XCTAssertNotNil(error)
      XCTAssertEqual(error, "error")
    }
  }
  
  func testFetchRegistersToEventThenSuccesReturnUsers() {
    
    dataManager.fetchUserRegisterToEvent(event: FakeData.eventWithRegisters) { users in
      XCTAssertNotNil(users)
      XCTAssertEqual(users[0], FakeData.userDetails)
    } errorHandler: { error in
      XCTAssertNil(error)
    }
  }
  
  func testFetchRegisterToEventThenSuccessReturnEmptyArray() {
    
    dataManager.fetchUserRegisterToEvent(event: FakeData.eventWithNoRegisters) { users in
      XCTAssertNotNil(users)
      XCTAssertTrue(users.isEmpty)
    } errorHandler: { error in
      XCTAssertNil(error)
    }
  }
  
  func testFetchRegisterToEventThenReturnErrorAndString() {
    
    dataManagerFailed.fetchUserRegisterToEvent(event: FakeData.eventWithRegisters) { users in
      XCTAssertNil(users)
    } errorHandler: { error in
      XCTAssertNotNil(error)
      XCTAssertEqual(error, "error")
    }
  }
  
  func testSetAdminCredentialToUserThenReturnSuccessMessage() {
    
    dataManager.setUserAdminCredentials(userId: FakeData.registeredUser.id) { message in
      XCTAssertNotNil(message)
      XCTAssertEqual(message, NSLocalizedString("modificationComplete", comment: ""))
    }
  }
  
  func testSetAdminCredentialToUserThenReturnErrorMessage() {
    
    dataManagerFailed.setUserAdminCredentials(userId: FakeData.registeredUser.id) { message in
      XCTAssertNotNil(message)
      XCTAssertEqual(message, "error")
    }
  }
  
  func testFetchAllUserThenReturnLimitedDetailsArray() {
    
    dataManager.fetchlimitUsersDetailsAdmin { users, error in
      XCTAssertNotNil(users)
      XCTAssertEqual(users![0].id, FakeData.registeredUser.id)
    }
  }
  
  func testFetchAllUsersThenReturnError() {
    
    dataManagerFailed.fetchLimitedDetailAdminList { users, error in
      XCTAssertNil(users)
      XCTAssertNotNil(error)
      XCTAssertEqual(error, NSLocalizedString("failFetchUserList", comment: ""))
    }
  }
}
