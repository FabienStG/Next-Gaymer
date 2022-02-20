//
//  DataManagerUserTests.swift
//  Next GaymerTests
//
//  Created by Fabien Saint Germain on 14/02/2022.
//

import XCTest
@testable import Next_Gaymer

class DataManagerUserTests: XCTestCase {
  
  let dataManager = DataManager(registrationServices: MockedRegistrationServices(), chatServices: MockedChatServices(),
                                eventServices: MockedEventServices(), adminServices: MockedAdminServices(),
                                userServices: MockedUserServices())
  
  let dataManagerFailed = DataManager(registrationServices: MockedRegistrationServicesFailed(), chatServices: MockedChatServicesFailed(),
                                      eventServices: MockedEventServicesFailed(), adminServices: MockedAdminServicesFailed(),
                                      userServices: MockedUserServicesFailed())


  func testFetchAdminListThenReturnAdminArray() {
    
    dataManager.fetchLimitedDetailAdminList { admins, error in
      XCTAssertNotNil(admins)
      XCTAssertEqual(admins![0].id, FakeData.registeredAdmin.id)
      XCTAssertNil(error)
    }
  }
  
  func testFetchAdminListThenReturnEmptyArrayAndError() {
    
    dataManagerFailed.fetchLimitedDetailAdminList { admins, error in
      XCTAssertNil(admins)
      XCTAssertNotNil(error)
      XCTAssertEqual(error, NSLocalizedString("failFetchUserList", comment: ""))
      
    }
  }
  
  func testFetchCurrentUserThenReturnREgistered() {
    
    dataManager.fetchCurrentUser { currentUser, error in
      XCTAssertNotNil(currentUser)
      XCTAssertEqual(currentUser!.id, FakeData.registeredUser.id)
      XCTAssertNil(error)
    }
  }
  
  func testFetchCurrentUserThenReturnError() {
    
    dataManagerFailed.fetchCurrentUser { currentUser, error in
      XCTAssertNil(currentUser)
      XCTAssertNotNil(error)
      XCTAssertEqual(error, "error")
    }
  }
  
  func testReauthenticateUserThenReturnTrue() {
    
    dataManager.reauthenticateUser(email: "test", password: "test") { response, error in
      XCTAssertNil(error)
      XCTAssertTrue(response)
    }
  }
  
  func testReauthenticateUserThenReturnFalseAndError() {
    
    dataManagerFailed.reauthenticateUser(email: "test", password: "test") { response, error in
      XCTAssertFalse(response)
      XCTAssertNotNil(error)
    }
  }
  
  func testDeleteUserThenReturnTrue() {
    
    dataManager.deleteUser { response, error in
      XCTAssertTrue(response)
      XCTAssertNil(error)
    }
  }
  
  func testDeleteUserThenReturnFalseAndError() {
    
    dataManagerFailed.deleteUser { response, error in
      XCTAssertFalse(response)
      XCTAssertNotNil(error)
    }
  }
  
  func testUpdateUserInfoThenReturnTrueAndConfirmAlert() {
    
    dataManager.updateUserInfo(userInfo: [:]) { response, error in
      XCTAssertTrue(response)
      XCTAssertEqual(error, NSLocalizedString("modificationComplete", comment: ""))
    }
  }
  
  func testUpdateUserInfoThenReturnFalseAndError() {
    
    dataManagerFailed.updateUserInfo(userInfo: [:]) { response, error in
      XCTAssertFalse(response)
      XCTAssertNotNil(error)
    }
  }
}
