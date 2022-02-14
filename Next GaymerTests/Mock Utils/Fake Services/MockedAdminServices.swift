//
//  MockedAdminServices.swift
//  Next GaymerTests
//
//  Created by Fabien Saint Germain on 14/02/2022.
//

import Foundation
@testable import Next_Gaymer

class MockedAdminServices: AdminServices {
  
  func setUserAdminCredentials(userId: String, completionHandler: @escaping (String) -> Void) {
    return completionHandler(NSLocalizedString("modificationComplete", comment: ""))
  }
  
  func fetchAllUsers(successHandler: @escaping ([UserRegistered]) -> Void, errorHandler: @escaping (String) -> Void) {
    return successHandler(FakeData.allRegisteredUsers)
  }
  
  func fetchEventRegistrants(event: EventCreated, successHandler: @escaping ([UserDetails]) -> Void, errorHandler: @escaping (String) -> Void) {
    return successHandler(event.registrant)
  }
}

class MockedAdminServicesFailed: AdminServices {
  func setUserAdminCredentials(userId: String, completionHandler: @escaping (String) -> Void) {
    return completionHandler("error")
  }
  
  func fetchAllUsers(successHandler: @escaping ([UserRegistered]) -> Void, errorHandler: @escaping (String) -> Void) {
    return errorHandler(NSLocalizedString("failFetchUserList", comment: ""))
  }
  
  func fetchEventRegistrants(event: EventCreated, successHandler: @escaping ([UserDetails]) -> Void, errorHandler: @escaping (String) -> Void) {
    return errorHandler("error")
  }
}
