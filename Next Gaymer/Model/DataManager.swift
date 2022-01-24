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
  private let firebaseChatService = FirebaseChatServices()
  
  let firebaseAdminService = FirebaseAdminService()

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
  
  func fetchCurrentUser(completionHandler: @escaping(UserRegistered?, String?) -> Void) {
    firebaseUserService.fetchCurrentUser { user in
      return completionHandler(user, nil)
    } errorHandler: { error in
      return completionHandler(nil, error)
    }
  }
  
  private func fetchAllUsers(completionHandler: @escaping([UserRegistered]?, String?) -> Void) {
    firebaseAdminService.fetchAllUsers { allUsers in
      return completionHandler(allUsers, nil)
    } errorHandler: { error in
      return completionHandler(nil, error)
    }
  }
  
  func fetchlimitUsersDetailsAdmin(completionHandler: @escaping([UserDetailsAdmin]?, String?) -> Void) {
    var usersLimitedDetailsList = [UserDetailsAdmin]()
    
    fetchAllUsers { allUsers, error in
      if let allUsers = allUsers {
        allUsers.forEach { user in
          let userDetailAdmin = UserDetailsAdmin(id: user.id, pseudo: user.pseudo, name: user.name, surname: user.surname, email: user.email, city: user.city, profileImageUrl: user.profileImageUrl, isAdmin: user.isAdmin)
          usersLimitedDetailsList.append(userDetailAdmin)
        }
        return completionHandler(usersLimitedDetailsList, nil)
      } else {
        return completionHandler(nil, error)
      }
    }
  }
  
  func saveMessage(textMessage: String, senderUser: UserRegistered, recipientUser: UserDetailsAdmin, completionHandler: @escaping(Bool, String?) -> Void) {
    firebaseChatService.saveMessage(textMessage: textMessage, recipientUserId: recipientUser.id) { saveResponse, saveError in
      if saveResponse {
        self.firebaseChatService.saveRecentMessage(textMessage: textMessage, senderUser: senderUser, recipientUser: recipientUser) { recentResponse, recentError in
          if recentResponse {
            return completionHandler(true, nil)
          } else {
            return completionHandler(false, recentError)
          }
        }
      } else {
        return completionHandler(false, saveError)
      }
    }
  }
  
}

enum RequestStatus {

  case initial
  case processing
  case success
  case fail
}
