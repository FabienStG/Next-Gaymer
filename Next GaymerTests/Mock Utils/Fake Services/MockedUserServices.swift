//
//  MockedUserServices.swift
//  Next GaymerTests
//
//  Created by Fabien Saint Germain on 14/02/2022.
//

import Foundation
@testable import Next_Gaymer

class MockedUserServices: UserServices {
  
  
  func fetchCurrentUser(successHandler: @escaping (UserRegistered) -> Void, errorHandler: @escaping (String) -> Void) {
    return successHandler(FakeData.registeredUser)
  }
  
  func fetchAllAdmin(successHandler: @escaping ([UserRegistered]) -> Void, errorHandler: @escaping (String) -> Void) {
    var allUsers = [UserRegistered]()
    var returnArray = [UserRegistered]()
    allUsers.append(FakeData.registeredUser)
    allUsers.append(FakeData.registeredAdmin)
    
    allUsers.forEach { user in
      if user.isAdmin {
        returnArray.append(user)
      }
    }
    return successHandler(returnArray)
  }
  
  func deleteCurrentUser(completionHandler: @escaping (Bool, String?) -> Void) {
    return completionHandler(true, nil)
  }
  
  func updateUserInfo(userInfo: [String : Any], completionHandler: @escaping (Bool, String) -> Void) {
    return completionHandler(true, NSLocalizedString("modificationComplete", comment: ""))
  }
  
  func reauthenticateUser(email: String, password: String, completionHandler: @escaping(Bool, String?) -> Void) {
    return completionHandler(true, nil)
  }
}

class MockedUserServicesFailed: UserServices {
  
  
  func fetchCurrentUser(successHandler: @escaping (UserRegistered) -> Void, errorHandler: @escaping (String) -> Void) {
    return errorHandler("error")
  }
  
  func fetchAllAdmin(successHandler: @escaping ([UserRegistered]) -> Void, errorHandler: @escaping (String) -> Void) {
    return errorHandler(NSLocalizedString("failFetchUserList", comment: ""))
  }
  
  func deleteCurrentUser(completionHandler: @escaping (Bool, String?) -> Void) {
    return completionHandler(false, "error")
  }
  
  func updateUserInfo(userInfo: [String : Any], completionHandler: @escaping (Bool, String) -> Void) {
    return completionHandler(false, "error")
  }
  
  func reauthenticateUser(email: String, password: String, completionHandler: @escaping(Bool, String?) -> Void) {
    return completionHandler(false, "error")
  }
}
