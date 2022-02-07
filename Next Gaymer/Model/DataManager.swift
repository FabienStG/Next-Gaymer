//
//  DataManager.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 14/01/2022.
//

import SwiftUI
//
// MARK: - Data Manager
//

/// Data Manager Class
/// This class provide to all the ViewModels the methods to work with Firebase.
/// It manage all the Services class
class DataManager {
  //
  // MARK: - Singleton
  //
  static let shared = DataManager()

  private init() {}

  //
  // MARK: - Private Constants
  //
  private let firebaseUserService = FirebaseUserService()
  private let firebaseChatService = FirebaseChatServices()
  private let firebaseEventService = FirebaseEventServices()
  private let firebaseAdminService = FirebaseAdminService()

  //
  // MARK: - App Storage Log Status
  //
  /// Save the log status in the app to avoid a relog when the user leave
  @AppStorage("log_status") var logStatus = false
  
  //
  // MARK: - Internal Methods - User Services
  //
  /// Log the user into the app and update the logstatus
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

  /// Log the user into the app thanks to the google login API
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

  /// Log out the user from the app and update the log status
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

  /// User the firebase service to send and email and reset the pasword
  func resetPassword(email: String, completionHandler: @escaping(Bool, String?) -> Void) {
    
    firebaseUserService.resetPassword(emailUser: email) { response, message in
      if !response {
        return completionHandler(response, message)
      }
      return completionHandler(response, nil)
    }
  }
  
  /// It the manager side of the main function who return the current user profile
  func fetchCurrentUser(completionHandler: @escaping(UserRegistered?, String?) -> Void) {
    
    firebaseUserService.fetchCurrentUser { user in
      return completionHandler(user, nil)
    } errorHandler: { error in
      return completionHandler(nil, error)
    }
  }
  
  /// This function manage all the needs when a user is created. It create it in the authentification base and create his complete profile in firestore
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
  
  //
  // MARK: - Internal Methods - Admin Services
  //
  /// This function, for admin user only, fetch all the users and return a array of limited informations for privecy purposes
  func fetchlimitUsersDetailsAdmin(completionHandler: @escaping([UserDetails]?, String?) -> Void) {
    
    var usersLimitedDetailsList = [UserDetails]()
    fetchAllUsers { allUsers, error in
      if let allUsers = allUsers {
        allUsers.forEach { user in
          let userDetailAdmin = UserDetails(id: user.id, pseudo: user.pseudo, name: user.name,
                                            surname: user.surname, email: user.email, city: user.city,
                                            profileImageUrl: user.profileImageUrl, isAdmin: user.isAdmin)
          usersLimitedDetailsList.append(userDetailAdmin)
        }
        return completionHandler(usersLimitedDetailsList, nil)
      } else {
        return completionHandler(nil, error)
      }
    }
  }
  
  /// This function create an event. First save the image in the storage and provide the url to the final object who'll be saved in firestore
  func createEvent(event: EventForm, image: UIImage, completionHandler: @escaping(Bool, String?) -> Void) {
    
    firebaseEventService.saveEventImage(image: image, eventId: event.id.uuidString) { response, url in
      if response {
        self.firebaseEventService.createEvent(with: event, imageUrl: url) { resonse, error in
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
  
  /// This function give to the selected user the admin credentials by updating his profile
  func setUserAdminCredentials(userId: String, completionHandler: @escaping(String) -> Void) {
    firebaseAdminService.setUserAdminCredentials(userId: userId) { message in
      return completionHandler(message)
    }
  }
  
  /// Take the event registered id, and fetch all the registered users from his array to return it
  func fetchUserRegisterToEvent(event: EventCreated, successHandler: @escaping([UserDetails]) -> Void, errorHandler: @escaping(String) -> Void) {
    firebaseAdminService.fetchEventRegistrants(event: event) { users in
      return successHandler(users)
    } errorHandler: { error in
      return errorHandler(error)
    }
  }
  
  //
  // MARK: - Internal Methods - Chat Services
  //
  /// Add the firebase listener for the chat log page and provide the protocol who'll recieve the updates
  func chatMessageListener(senderUser: UserRegistered, recipientUser: UserDetails, listen: Listener) {
    firebaseChatService.fetchMessages(senderUser: senderUser, recipientUser: recipientUser, listen: listen)
  }
  
  /// Ad the firebase listener for the main message page and provide the protocol who'll recieve the updates
  func recentMessageListener(currentUser: UserRegistered, listen: Listener) {
    firebaseChatService.fetchRecentMessages(currentUser: currentUser, listen: listen)
  }
  
  /// Use the firebase service to remove the chat listener
  func stopChatListening() {
    firebaseChatService.stopChatListening()
  }
  
  /// User the firebase service to remove the recent message listener
  func stopRecentMessageListening() {
    firebaseChatService.stopRecentMessageListening()
  }
  
  /// When a message is sent in the chat log, it saved it in the firestore to be read by the recipient, and save a copy as a recent message for the main message use
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
  
  /// With the selected user provided, return it with a limited number of informations as a User Detail object
  func fetchSpecificUser(selectedUser: String, completionHandler: @escaping(UserDetails?, String?) -> Void) {
    
    firebaseChatService.fetchSpecificUser(selectedUser: selectedUser) { userRegistered, error in
      if let error = error {
        return completionHandler(nil, error)
      } else if let userRegistered = userRegistered {
        let user = UserDetails(id: userRegistered.id, pseudo: userRegistered.pseudo, name: userRegistered.name,
                               surname: userRegistered.surname, email: userRegistered.email, city: userRegistered.city,
                               profileImageUrl: userRegistered.profileImageUrl, isAdmin: userRegistered.isAdmin)
        
        return completionHandler(user, nil)
      } else {
        return completionHandler(nil, NSLocalizedString("failFindUser", comment: ""))
      }
    }
  }
  
  //
  // MARK: - Internal Methods - Event Services
  //
  /// Use the firebase services to return an array of the event who the user is registrate
  func fetchMyEvents(completionHandler: @escaping([EventCreated], String?) -> Void) {
    firebaseEventService.fetchMyEvent { myEvent, error in
       return completionHandler(myEvent, error)
      }
    }
  
  /// Fetch all the registered events and return them as an array
  func fetchAllEvents(completionHandler: @escaping([EventCreated]?, String?) -> Void) {
    
    firebaseEventService.fetchAllEvents { allEvent in
      return completionHandler(allEvent, nil)
    } errorHandler: { error in
      return completionHandler(nil, error)
    }
  }
  
  /// When a user whant to registrate into an event, this function check first if the event is available, and saved into the registrent array of the event one
  func registrateUserForEvent(currentUser: UserRegistered, event: EventCreated, completionHandler: @escaping(Bool, String) -> Void) {
    
    firebaseEventService.checkIfEventAvailable(currentUser: currentUser, event: event) { checkResult, checkMessage in
      if checkResult {
        self.firebaseEventService.registrateUserForEvent(currentUser: currentUser, event: event) { result, message in
          self.firebaseEventService.addEventToUSer(event: event)
          return completionHandler(result, message)
        }
      } else if checkMessage != nil {
        return completionHandler(checkResult, checkMessage!)
      }
    }
  }
  
  /// Remove the user from the registrant array of the selected event
  func deleteUserFromEvent(currentUser: UserRegistered, event: EventCreated, completionHandler: @escaping(Bool, String) -> Void) {
    
    firebaseEventService.deleteUserFromEvent(currentUser: currentUser, event: event) { result, message in
      if result {
        self.firebaseEventService.removeEventToUser(event: event)
        return completionHandler(result, message)
      }
      return completionHandler(result, message)
    }
  }

  //
  // MARK: - Private Method
  //
  /// This function for admin only use return informations of all the registered users
  private func fetchAllUsers(completionHandler: @escaping([UserRegistered]?, String?) -> Void) {
    
    firebaseAdminService.fetchAllUsers { allUsers in
      return completionHandler(allUsers, nil)
    } errorHandler: { error in
      return completionHandler(nil, error)
    }
  }
}
