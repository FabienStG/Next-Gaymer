//
//  MockedRegistrationServices.swift
//  Next GaymerTests
//
//  Created by Fabien Saint Germain on 14/02/2022.
//

import SwiftUI
@testable import Next_Gaymer

class MockedRegistrationServices: RegistrationServices {
  
  func createUser(userEmail: String, userPassword: String, completionHandler: @escaping (Bool, String?) -> Void) {
    return completionHandler(true, nil)
  }
  
  func saveProfileImage(image: UIImage, completionHandler: @escaping (Bool, String) -> Void) {
    let imageUrl = FakeData.image
    return completionHandler(true, imageUrl)
  }
  
  func registrateUser(with user: UserForm, image: UIImage, completionHandler: @escaping (Bool, String?) -> Void) {
    return completionHandler(true, nil)
  }
  
  func registrateGoogleUser(with user: UserRegistered, completionHandler: @escaping (Bool, String?) -> Void) {
    return completionHandler(true, nil)
  }
  
  func googleLoginUser(completionHandler: @escaping (Bool, String?) -> Void) {
    return completionHandler(true, nil)
  }
  
  func getGoogleUserInfo(completionHandler: @escaping ([String : String]?) -> Void) {
    let returnInfo = [
      UserConstant.email: "userEmail",
      UserConstant.phoneNumber: "user.phoneNumber",
      UserConstant.profileImageUrl: "user.photoURL",
      UserConstant.userId: "userId",
      UserConstant.name: "user.displayName"
    ]
    return completionHandler(returnInfo)
  }
  
  func loginUser(userEmail: String, userPassword: String, completionHandler: @escaping (Bool, String?) -> Void) {
    return completionHandler(true, nil)
  }
  
  func logoutUser(completionHandler: @escaping (Bool, String?) -> Void) {
    return completionHandler(true, nil)
  }
  
  func resetPassword(emailUser: String, completionHandler: @escaping (Bool, String?) -> Void) {
    return completionHandler(true, nil)
  }
}

class MockedRegistrationServicesFailed: RegistrationServices {
  
  func createUser(userEmail: String, userPassword: String, completionHandler: @escaping (Bool, String?) -> Void) {
    return completionHandler(false, NSLocalizedString("failCreateUser", comment: ""))
  }
  
  func saveProfileImage(image: UIImage, completionHandler: @escaping (Bool, String) -> Void) {
    return completionHandler(false, NSLocalizedString("failImageCompression", comment: ""))
  }
  
  func registrateUser(with user: UserForm, image: UIImage, completionHandler: @escaping (Bool, String?) -> Void) {
    return completionHandler(false, "error")
  }
  
  func registrateGoogleUser(with user: UserRegistered, completionHandler: @escaping (Bool, String?) -> Void) {
    return completionHandler(false, "error")
  }
  
  func googleLoginUser(completionHandler: @escaping (Bool, String?) -> Void) {
    return completionHandler(false, NSLocalizedString("failLogUser", comment: ""))
  }
  
  func getGoogleUserInfo(completionHandler: @escaping ([String : String]?) -> Void) {
    return completionHandler(nil)
  }
  
  func loginUser(userEmail: String, userPassword: String, completionHandler: @escaping (Bool, String?) -> Void) {
    return completionHandler(false, NSLocalizedString("failLogUser", comment: ""))
  }
  
  func logoutUser(completionHandler: @escaping (Bool, String?) -> Void) {
    return completionHandler(false, "error")
  }
  
  func resetPassword(emailUser: String, completionHandler: @escaping (Bool, String?) -> Void) {
    return completionHandler(false, "error")
  }
}
