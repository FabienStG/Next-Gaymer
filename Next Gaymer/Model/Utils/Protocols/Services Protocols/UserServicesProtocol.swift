//
//  UserServicesProtocol.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 14/02/2022.
//

import Foundation
//
// MARK: - User Services Protocol
//

/// This protocol help for the firebase mocking tests
protocol UserServices {

  func fetchCurrentUser(successHandler: @escaping(UserRegistered) -> Void, errorHandler: @escaping(String) -> Void)
  
  func fetchAllAdmin(successHandler: @escaping ([UserRegistered]) -> Void, errorHandler: @escaping(String) -> Void)
  
  func deleteCurrentUser(completionHandler: @escaping(Bool, String?) -> Void)
  
  func updateUserInfo(userInfo: [String: Any], completionHandler: @escaping(Bool, String) -> Void)
  
  func reauthenticateUser(email: String, password: String, completionHandler: @escaping(Bool, String?) -> Void)
}
