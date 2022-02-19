//
//  RegistrationServicesProtocol.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 14/02/2022.
//

import SwiftUI
//
// MARK: - Registration Services Protocol
//

/// This protocol help for the firebase mocking tests
protocol RegistrationServices {

  func createUser(userEmail: String, userPassword: String, completionHandler: @escaping(Bool, String?) -> Void)
  
  func saveProfileImage(image: UIImage, completionHandler: @escaping(Bool, String) -> Void)
  
  func checkGoogleUserAppAccount(completionHandler: @escaping(Bool) -> Void)
  
  func registrateUser(with user: UserForm, image: UIImage, completionHandler: @escaping(Bool, String?) -> Void)
  
  func registrateGoogleUser(with user: UserRegistered, completionHandler: @escaping(Bool, String?) -> Void)
  
  func googleLoginUser(completionHandler: @escaping(Bool, String?) -> Void)
  
  func getGoogleUserInfo(completionHandler: @escaping([String: String]) -> Void)
  
  func loginUser(userEmail: String, userPassword: String, completionHandler: @escaping(Bool, String?) -> Void)

  func logoutUser(completionHandler: @escaping(Bool, String?) -> Void)
  
  func resetPassword(emailUser: String, completionHandler: @escaping(Bool, String?) -> Void)
}
