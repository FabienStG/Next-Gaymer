//
//  DataManagerChatTests.swift
//  Next GaymerTests
//
//  Created by Fabien Saint Germain on 14/02/2022.
//

import XCTest
@testable import Next_Gaymer

class DataManagerChatTests: XCTestCase {
  
  let dataManager = DataManager(registrationServices: MockedRegistrationServices(), chatServices: MockedChatServices(),
                                eventServices: MockedEventServices(), adminServices: MockedAdminServices(),
                                userServices: MockedUserServices())
  
  let dataManagerFailed = DataManager(registrationServices: MockedRegistrationServicesFailed(), chatServices: MockedChatServicesFailed(),
                                      eventServices: MockedEventServicesFailed(), adminServices: MockedAdminServicesFailed(),
                                      userServices: MockedUserServicesFailed())

  
  func testFetchSpecificUserThenReturnIt() {
    
    dataManager.fetchSpecificUser(selectedUser: FakeData.registeredUser.id) { user, error in
      XCTAssertNotNil(user)
      XCTAssertEqual(user!.id, FakeData.registeredAdmin.id)
      XCTAssertNil(error)
    }
  }
  
  func testFetchSpecificUserThenReturnError() {
    
    dataManagerFailed.fetchSpecificUser(selectedUser: FakeData.registeredUser.id) { user, error in
      XCTAssertNil(user)
      XCTAssertNotNil(error)
      XCTAssertEqual(error, NSLocalizedString("failFindUser", comment: ""))
    }
  }
  
  func testSaveMessageThenReturnSuccess() {
    
    dataManager.saveMessage(textMessage: "Test", senderUser: FakeData.registeredUser, recipientUser: FakeData.userDetails) { response, error in
      XCTAssertTrue(response)
      XCTAssertNil(error)
    }
  }
  
  func testSaveMessageThenReturnFailedAndError() {
    
    dataManagerFailed.saveMessage(textMessage: "Test", senderUser: FakeData.registeredUser, recipientUser: FakeData.userDetails) { response, error in
      XCTAssertFalse(response)
      XCTAssertNotNil(error)
      XCTAssertEqual(error, "error")
    }
  }
}
