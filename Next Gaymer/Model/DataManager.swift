//
//  DataManager.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 14/01/2022.
//

import SwiftUI

class DataManager {

  static let shared = DataManager()

  private init() {}

  private let firebaseUserService = FirebaseUserService()

  @AppStorage("log_status") var logStatus = false

  func registerUser(with user: UserDetailsForm, password: String, image: UIImage, completionHandler: @escaping(Bool, String?) -> Void) {

    firebaseUserService.createUser(userEmail: user.email, userPassword: password) { response, authMessage in
      if response {
        self.firebaseUserService.registrateUser(with: user, image: image) { response, dbMessage in
          if response {
            self.logStatus = true
            return completionHandler(true, nil)
          } else {
            return completionHandler(false, dbMessage)
          }
        }
      } else {
        return completionHandler(false, authMessage)
      }
    }
  }

  func loginUser(email: String, password: String, completionHandler: @escaping(Bool, String?) -> Void) {
    firebaseUserService.loginUser(userEmail: email, userPassword: password) { response, message in
      if response {
        self.logStatus = true
        return completionHandler(response, nil)
      } else {
        return completionHandler(response, message)
      }
    }
  }

  func googleLoginUser(completionHandler: @escaping(Bool, String?) -> Void) {
    firebaseUserService.googleLoginUser { response, message in
      if response {
        self.logStatus = true
        return completionHandler(response, nil)
      } else {
  return completionHandler(response, message)
      }
    }
  }

  func logoutUser(completionHandler: @escaping(Bool, String?) -> Void) {
    firebaseUserService.logoutUser { response, message in
      if response {
        self.logStatus = false
        return completionHandler(response, nil)
      } else {
        return completionHandler(response, message)
      }
    }
  }

  func resetPassword(email: String, completionHandler: @escaping(Bool, String?) -> Void) {
    firebaseUserService.resetPassword(emailUser: email) { response, message in
      if !response {
        return completionHandler(response, message)
      }
      return completionHandler(response, nil)
    }
  }
}

enum RequestStatus {

  case initial
  case processing
  case success
  case fail
}
