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
  private let firebaseEventService = FirebaseEventServices()
  
  
  let firebaseAdminService = FirebaseAdminService()

  @AppStorage("log_status") var logStatus = false
  
  //
  // MARK: - Users Services
  //
  func registerUser(with user: UserForm, password: String, image: UIImage, completionHandler: @escaping(Bool, String?) -> Void) {

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
  
  //
  // MARK: - Admin Services
  //
  
  private func fetchAllUsers(completionHandler: @escaping([UserRegistered]?, String?) -> Void) {
    firebaseAdminService.fetchAllUsers { allUsers in
      return completionHandler(allUsers, nil)
    } errorHandler: { error in
      return completionHandler(nil, error)
    }
  }
    
  func fetchlimitUsersDetailsAdmin(completionHandler: @escaping([UserDetails]?, String?) -> Void) {
    var usersLimitedDetailsList = [UserDetails]()
    
    fetchAllUsers { allUsers, error in
      if let allUsers = allUsers {
        allUsers.forEach { user in
          let userDetailAdmin = UserDetails(id: user.id, pseudo: user.pseudo, name: user.name, surname: user.surname, email: user.email, city: user.city, profileImageUrl: user.profileImageUrl, isAdmin: user.isAdmin)
          usersLimitedDetailsList.append(userDetailAdmin)
        }
        return completionHandler(usersLimitedDetailsList, nil)
      } else {
        return completionHandler(nil, error)
      }
    }
  }
  
  func setUserAdminCredentials(userId: String, completionHandler: @escaping(String) -> Void) {
    firebaseAdminService.setUserAdminCredentials(userId: userId) { message in
      return completionHandler(message)
    }
  }
  
  //
  // MARK: - Chat Services
  //
  
  func saveMessage(textMessage: String, senderUser: UserRegistered, recipientUser: UserDetails, completionHandler: @escaping(Bool, String?) -> Void) {
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
  
  func fetchSpecificUser(selectedUser: String, completionHandler: @escaping(UserDetails?, String?) -> Void) {
    firebaseChatService.fetchSpecificUser(selectedUser: selectedUser) { userRegistered, error in
      if let error = error {
        return completionHandler(nil, error)
      } else if let userRegistered = userRegistered {
        let user = UserDetails(id: userRegistered.id, pseudo: userRegistered.pseudo, name: userRegistered.name, surname: userRegistered.surname, email: userRegistered.email, city: userRegistered.city, profileImageUrl: userRegistered.profileImageUrl, isAdmin: userRegistered.isAdmin)
        
        return completionHandler(user, nil)
      } else {
        return completionHandler(nil, "Impossible de retrouver l'utilisateur")
      }
    }
  }
  
  func messageListener(senderUser: UserRegistered, recipientUser: UserDetails, listen: Listener) {
    firebaseChatService.fetchMessages(senderUser: senderUser, recipientUser: recipientUser, listen: listen)
  }
  
  //
  // MARK: - Event Services
  //
  
  func createEvent(event: EventForm, image: UIImage, completionHandler: @escaping(Bool, String?) -> Void) {
    firebaseEventService.saveEventImage(image: image, eventId: event.id.uuidString) { response, url in
      if response {
        self.firebaseEventService.registrateEvent(with: event, imageUrl: url) { resonse, error in
          if let error = error {
            return completionHandler(false, error)
          } else {
            return completionHandler(true, nil)
          }
        }
      } else {
        return completionHandler(false, url)
      }
    }
  }
  
}
