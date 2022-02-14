//
//  DataManagerUserTests.swift
//  Next GaymerTests
//
//  Created by Fabien Saint Germain on 14/02/2022.
//

import XCTest
@testable import Next_Gaymer

class DataManagerUserTests: XCTestCase {
  
  let dataManager = DataManager(regitrationServices: MockedRegistrationServices(), chatServices: MockedChatServices(),
                                eventServices: MockedEventServices(), adminServices: MockedAdminServices(),
                                userServices: MockedUserServices())
  
  let dataManagerFailed = DataManager(regitrationServices: MockedRegistrationServicesFailed(), chatServices: MockedChatServicesFailed(),
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
}
