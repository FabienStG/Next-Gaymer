//
//  DataManagerRegisterTests.swift
//  Next GaymerTests
//
//  Created by Fabien Saint Germain on 14/02/2022.
//

import XCTest
@testable import Next_Gaymer

class DataManagerRegisterTests: XCTestCase {
  
  let dataManager = DataManager(regitrationServices: MockedRegistrationServices(), chatServices: MockedChatServices(),
                                eventServices: MockedEventServices(), adminServices: MockedAdminServices(),
                                userServices: MockedUserServices())
  
  let dataManagerFailed = DataManager(regitrationServices: MockedRegistrationServicesFailed(), chatServices: MockedChatServicesFailed(),
                                      eventServices: MockedEventServicesFailed(), adminServices: MockedAdminServicesFailed(),
                                      userServices: MockedUserServicesFailed())

  func testRegisterUserThenReturnSuccessAndLogIn() {
    
    XCTAssertFalse(UserLogStatus.shared.logStatus)
    dataManager.registerUser(with: FakeData.userForm, password: "password", image: FakeData.uiImage!) { response, error in
      
      XCTAssertTrue(response)
      XCTAssertTrue(UserLogStatus.shared.logStatus)
      XCTAssertNil(error)
    }
  }
  
  func testRegisterUserThenReturnErrorAndNotLogin() {
    
    XCTAssertFalse(UserLogStatus.shared.logStatus)
    dataManagerFailed.registerUser(with: FakeData.userForm, password: "password", image: FakeData.uiImage!) { response, error in
      XCTAssertFalse(response)
      XCTAssertFalse(UserLogStatus.shared.logStatus)
    }
  }

}
