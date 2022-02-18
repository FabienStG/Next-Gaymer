//
//  DataManagerRegisterTests.swift
//  Next GaymerTests
//
//  Created by Fabien Saint Germain on 14/02/2022.
//

import XCTest
@testable import Next_Gaymer

class DataManagerRegisterTests: XCTestCase {
  
  let dataManager = DataManager(registrationServices: MockedRegistrationServices(), chatServices: MockedChatServices(),
                                eventServices: MockedEventServices(), adminServices: MockedAdminServices(),
                                userServices: MockedUserServices())
  
  let dataManagerFailed = DataManager(registrationServices: MockedRegistrationServicesFailed(), chatServices: MockedChatServicesFailed(),
                                      eventServices: MockedEventServicesFailed(), adminServices: MockedAdminServicesFailed(),
                                      userServices: MockedUserServicesFailed())
  


  
  func testRegisterUserThenReturnSuccessAndLogIn() {
    
    UserLogStatus.shared.logStatus = false
    dataManager.registerUser(with: FakeData.userForm, password: "password", image: FakeData.uiImage!) { response, error in
      
      XCTAssertTrue(response)
      XCTAssertTrue(UserLogStatus.shared.logStatus)
      XCTAssertNil(error)
    }
  }
  
  func testRegisterUserThenReturnErrorAndNotLogin() {
    
    UserLogStatus.shared.logStatus = false
    dataManagerFailed.registerUser(with: FakeData.userForm, password: "password", image: FakeData.uiImage!) { response, error in
      XCTAssertFalse(response)
      XCTAssertEqual(error, NSLocalizedString("failCreateUser", comment: ""))
      XCTAssertFalse(UserLogStatus.shared.logStatus)
    }
  }
  
  func testLoginUserThenReturnSuccessAndLogIn() {
    
    UserLogStatus.shared.logStatus = false
    dataManager.loginUser(email: "mail", password: "password") { response, error in
      XCTAssertTrue(response)
      XCTAssertTrue(UserLogStatus.shared.logStatus)
      XCTAssertNil(error)
    }
  }
  
  func testLoginUserThenReturnFailedAndError() {
    
    UserLogStatus.shared.logStatus = false
    dataManagerFailed.loginUser(email: "mail", password: "password") { response, error in
      XCTAssertFalse(response)
      XCTAssertFalse(UserLogStatus.shared.logStatus)
      XCTAssertNotNil(error)
      XCTAssertEqual(error, NSLocalizedString("failLogUser", comment: ""))
    }
  }
  
  func testLoginGoogleUserThenReturnSuccessAndLogIn() {
    
    UserLogStatus.shared.logStatus = false
    dataManager.googleLoginUser { response, error in
      XCTAssertTrue(response)
      XCTAssertTrue(UserLogStatus.shared.logStatus)
      XCTAssertNil(error)
    }
  }
  
  func testLoginGoogleUserThenReturnFailedAndError() {
    
    UserLogStatus.shared.logStatus = false
    dataManagerFailed.googleLoginUser { response, error in
      XCTAssertFalse(response)
      XCTAssertFalse(UserLogStatus.shared.logStatus)
      XCTAssertNotNil(error)
      XCTAssertEqual(error, NSLocalizedString("failLogUser", comment: ""))
    }
    UserLogStatus.shared.logStatus = false
  }
  
  func testFetchGoogleUserInfoThenReturnDictionnary() {
    
    dataManager.fetchGoogleUserInfo { info in
      XCTAssertNotNil(info)
      XCTAssertEqual(info["userId"], "userId")
    }
  }
  
  func testFetchGoogleUserInfoThenReturnEmpty() {
    
    dataManagerFailed.fetchGoogleUserInfo { info in
      XCTAssertNotNil(info)
    }
  }

  func testLogoutUserThenReturnSuccessAndLogOut() {
    
    UserLogStatus.shared.logStatus = true
    dataManager.logoutUser { response, error in
      XCTAssertTrue(response)
      XCTAssertFalse(UserLogStatus.shared.logStatus)
      XCTAssertNil(error)
    }
    UserLogStatus.shared.logStatus = false
  }
  
  func testLogoutUserThenReturnFaildAndError() {
    
    UserLogStatus.shared.logStatus = true
    dataManagerFailed.logoutUser { response, error in
      XCTAssertFalse(response)
      XCTAssertTrue(UserLogStatus.shared.logStatus)
      XCTAssertNotNil(error)
      XCTAssertEqual(error, "error")
    }
    UserLogStatus.shared.logStatus = false
  }
  
  func testResetPasswordThenReturnSuccess() {
    
    dataManager.resetPassword(email: "mail") { response, error in
      XCTAssertTrue(response)
      XCTAssertNil(error)
    }
  }
  
  func testResetPasswordThenReturnFailedAndError() {
    
    dataManagerFailed.resetPassword(email: "mail") { response, error in
      XCTAssertFalse(response)
      XCTAssertNotNil(error)
      XCTAssertEqual(error, "error")
    }
  }
  
  func testCheckIfGoogleHaveAlreadyAccountThenReturnTrue() {
    
    dataManager.checkGoogleUserAppAccount { result in
      XCTAssertTrue(result)
    }
  }
  
  func testCheckIfGoogleHaveAlreadyAccountThenReturnFalse() {
    
    dataManagerFailed.checkGoogleUserAppAccount { result in
      XCTAssertFalse(result)
    }
  }
 }
