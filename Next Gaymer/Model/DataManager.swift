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
  static var _shared: DataManager?

  //
  // MARK: - Private Constants
  //
  private let registrationServices: RegistrationServices
  private let chatServices: ChatServices
  private let eventServices: EventServices
  private let adminServices: AdminServices
  private let userServices: UserServices
  private let centerServices: CenterServices
  
  //
  // MARK: - Initilizalisation
  //
  init(registrationServices: RegistrationServices, chatServices: ChatServices,
       eventServices: EventServices, adminServices: AdminServices, userServices: UserServices, centerServices: CenterServices) {
    self.registrationServices = registrationServices
    self.chatServices = chatServices
    self.eventServices = eventServices
    self.adminServices = adminServices
    self.userServices = userServices
    self.centerServices = centerServices
  }

  //
  // MARK: - Class Methods
  //
  /// Function who initialize the manage with the provide services
  static func initialized(registrationServices: RegistrationServices, chatServices: ChatServices,
                          eventServices: EventServices, adminServices: AdminServices, userServices: UserServices, centerServices: CenterServices) {
    _shared = DataManager(registrationServices: registrationServices, chatServices: chatServices,
                          eventServices: eventServices, adminServices: adminServices, userServices: userServices, centerServices: centerServices)
  }

  /// Function to use the force unwrapp the _shared instance initialized in the app
  static func shared() -> DataManager {
    return _shared!
  }
  
  //
  // MARK: - Internal Methods - Registration Services
  //
  /// Log the user into the app and update the logstatus
  func loginUser(email: String, password: String, completionHandler: @escaping(Bool, String?) -> Void) {
    
    registrationServices.loginUser(userEmail: email, userPassword: password) { response, message in
      if response {
        UserLogStatus.shared.logStatus = true
        return completionHandler(response, nil)
      } else {
        return completionHandler(response, message)
      }
    }
  }

  /// Log the user into the app thanks to the google login API
  func googleLoginUser(completionHandler: @escaping(Bool, String?) -> Void) {
    
    registrationServices.googleLoginUser { response, message in
      if response {
        UserLogStatus.shared.logStatus = true
        return completionHandler(response, nil)
      } else {
        return completionHandler(response, message)
      }
    }
  }
  
  /// Return the saved currentUser info from google signin
  func fetchGoogleUserInfo(completionHandler: @escaping([String: String]) -> Void) {
    
    registrationServices.getGoogleUserInfo { info in
        return completionHandler(info)
    }
  }
  
  /// Check if the user have already an app account and sign in
  func checkGoogleUserAppAccount(completionHandler: @escaping(Bool) -> Void) {
    
    registrationServices.checkGoogleUserAppAccount { result in
      return completionHandler(result)
    }
  }
  
  /// This function manage all the needs when a user is created. It create it in the authentification base and create his complete profile in firestore
  func registerUser(with user: UserForm, password: String, image: UIImage, completionHandler: @escaping(Bool, String?) -> Void) {

    registrationServices.createUser(userEmail: user.email, userPassword: password) { response, authMessage in
      if response {
        self.registrationServices.registrateUser(with: user, image: image) { response, dbMessage in
          if response {
            UserLogStatus.shared.logStatus = true
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
  
  /// This function create a regular user account for the app with the provided information by Google Sign in and completed by the user
  func registerGoogleUser(with user: UserRegistered, completionHandler: @escaping(Bool, String?) -> Void) {
    
    registrationServices.registrateGoogleUser(with: user) { response, error in
      if !response {
        return completionHandler(false, error)
      }
      UserLogStatus.shared.logStatus = true
      return completionHandler(true, nil)
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
          let userDetailAdmin = self.packUserDetail(user)
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
    
    eventServices.saveEventImage(image: image, eventId: event.id.uuidString) { response, url in
      if response {
                
        self.eventServices.createEvent(with: self.packEvent(event, url)) { resonse, error in
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
    adminServices.setUserAdminCredentials(userId: userId) { message in
      return completionHandler(message)
    }
  }
  
  /// Take the event registered id, and fetch all the registered users from his array to return it
  func fetchUserRegisterToEvent(event: EventCreated, successHandler: @escaping([UserDetails]) -> Void, errorHandler: @escaping(String) -> Void) {
    adminServices.fetchEventRegistrants(event: event) { users in
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
    chatServices.fetchMessages(senderUser: senderUser, recipientUser: recipientUser, listen: listen)
  }
  
  /// Ad the firebase listener for the main message page and provide the protocol who'll recieve the updates
  func recentMessageListener(listen: Listener) {
    chatServices.fetchRecentMessages(listen: listen)
  }
  
  /// Use the firebase service to remove the chat listener
  func stopChatListening() {
    chatServices.stopChatListening()
  }
  
  /// User the firebase service to remove the recent message listener
  func stopRecentMessageListening() {
    chatServices.stopRecentMessageListening()
  }
  
  /// When a message is sent in the chat log, it saved it in the firestore to be read by the recipient, and save a copy as a recent message for the main message use
  func saveMessage(textMessage: String, senderUser: UserRegistered, recipientUser: UserDetails, completionHandler: @escaping(Bool, String?) -> Void) {
    
    chatServices.saveMessage(textMessage: textMessage, recipientUserId: recipientUser.id) { saveResponse, saveError in
      if saveResponse {
        self.chatServices.saveRecentMessage(textMessage: textMessage, senderUser: senderUser, recipientUser: recipientUser) { recentResponse, recentError in
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
    
    chatServices.fetchSpecificUser(selectedUser: selectedUser) { userRegistered, error in
      if let error = error {
        return completionHandler(nil, error)
      } else if let userRegistered = userRegistered {
        let user = self.packUserDetail(userRegistered)
        return completionHandler(user, nil)
      }
    }
  }
  
  /// This function return an array with the admin users
  func fetchLimitedDetailAdminList(completionHandler: @escaping([UserDetails]?, String?) -> Void) {
    
    var adminLimitedDetailsList = [UserDetails]()
    fetchAllAdmin { allAdmin, error in
      if let allAdmin = allAdmin {
        allAdmin.forEach { user in
          let adminDetail = self.packUserDetail(user)
          adminLimitedDetailsList.append(adminDetail)
        }
        return completionHandler(adminLimitedDetailsList, nil)
      } else {
        return completionHandler(nil, error)
      }
    }
  }
  
  /// Delete the Reecent message sotck in the user collection
  func deleteRecentMessage(message: RecentMessage) {
    
    chatServices.deleteRecentMessage(message: message)
  }
  
  //
  // MARK: - Internal Methods - Event Services
  //
  /// Use the firebase services to return an array of the event who the user is registrate
  func fetchMyEvents(completionHandler: @escaping([EventCreated], String?) -> Void) {
    eventServices.fetchMyEvent { myEvent, error in
       return completionHandler(myEvent, error)
      }
    }
  
  /// Fetch all the registered events and return them as an array
  func fetchAllEvents(completionHandler: @escaping([EventCreated]?, String?) -> Void) {
    
    eventServices.fetchAllEvents { allEvent in
      return completionHandler(allEvent, nil)
    } errorHandler: { error in
      return completionHandler(nil, error)
    }
  }
  
  /// When a user whant to registrate into an event, this function check first if the event is available, and saved into the registrent array of the event one
  func registrateUserForEvent(currentUser: UserRegistered, event: EventCreated, completionHandler: @escaping(Bool, String) -> Void) {
    
    eventServices.checkIfEventAvailable(currentUser: currentUser, event: event) { checkResult, checkMessage in
      if checkResult {
        self.eventServices.registrateUserForEvent(currentUser: currentUser, event: event) { result, message in
          self.eventServices.addEventToUSer(event: event)
          return completionHandler(result, message)
        }
      } else if checkMessage != nil {
        return completionHandler(checkResult, checkMessage!)
      }
    }
  }
  
  /// Remove the user from the registrant array of the selected event
  func deleteUserFromEvent(currentUser: UserRegistered, event: EventCreated, completionHandler: @escaping(Bool, String) -> Void) {
    
    eventServices.deleteUserFromEvent(currentUser: currentUser, event: event) { result, message in
      if result {
        self.eventServices.removeEventToUser(event: event)
        return completionHandler(result, message)
      }
      return completionHandler(result, message)
    }
  }
  
  //
  // MARK: - Internal Methods - Profile Management Services
  //
  /// Log out the user from the app and update the log status
  func logoutUser(completionHandler: @escaping(Bool, String?) -> Void) {
    
    registrationServices.logoutUser { response, message in
      if response {
        UserLogStatus.shared.logStatus = false
        return completionHandler(response, nil)
      } else {
        return completionHandler(response, message)
      }
    }
  }

  /// User the firebase service to send and email and reset the pasword
  func resetPassword(email: String, completionHandler: @escaping(Bool, String?) -> Void) {
    
    registrationServices.resetPassword(emailUser: email) { response, message in
      if !response {
        return completionHandler(response, message)
      }
      return completionHandler(response, nil)
    }
  }
  
  /// It the manager side of the main function who return the current user profile
  func fetchCurrentUser(completionHandler: @escaping(UserRegistered?, String?) -> Void) {
    
    userServices.fetchCurrentUser { user in
      return completionHandler(user, nil)
    } errorHandler: { error in
      return completionHandler(nil, error)
    }
  }
  
  /// Reauthenticate the user
  func reauthenticateUser(email: String, password: String, completionHandler: @escaping(Bool, String?) -> Void) {
    
    userServices.reauthenticateUser(email: email, password: password) { response, error in
      if !response {
        return completionHandler(false, error)
      }
      return completionHandler(true, nil)
    }
  }
  
  /// Delete the user from firebase auth and firestore app account
  func deleteUser(completionHandler: @escaping(Bool, String?) -> Void) {
    
    userServices.deleteCurrentUser { response, error in
      if response {
        UserLogStatus.shared.logStatus = false
      }
      return completionHandler(response, error)
    }
  }
  
  /// Update the current user info with new data
  func updateUserInfo(userInfo: [String: Any], completionHandler: @escaping(Bool, String?) -> Void) {
    
    userServices.updateUserInfo(userInfo: userInfo) { response, error in
      return completionHandler(response, error)
    }
  }
  
  //
  // MARK: - Internal Method - Help Centers Services
  //
  /// This function fetch the centers list
  func fetchCenterList(completionHandler: @escaping([HelpCenter]) -> Void) {
    
    var centersArray: [HelpCenter] = []
    
    centerServices.fetchCenterList { centerList in
      centerList.forEach { center in
        centersArray.append(self.packCenter(center))
      }
      return completionHandler(centersArray)
    }
  }

  //
  // MARK: - Private Methods
  //
  /// This function for admin only use return informations of all the registered users
  private func fetchAllUsers(completionHandler: @escaping([UserRegistered]?, String?) -> Void) {
    
    adminServices.fetchAllUsers { allUsers in
      return completionHandler(allUsers, nil)
    } errorHandler: { error in
      return completionHandler(nil, error)
    }
  }
  
  /// This function is the same than fetching all Users, but return only admin
  private func fetchAllAdmin(completionHandler: @escaping([UserRegistered]?, String?) -> Void) {
    
    userServices.fetchAllAdmin { allAdmin in
      return completionHandler(allAdmin, nil)
    } errorHandler: { error in
      return completionHandler(nil, error)
    }
  }
  
  /// Pack all event registered and create an object who'll be saved in firebase
  private func packEvent(_ event: EventForm, _ url: String) -> EventCreated {
    
    let eventCreated = EventCreated(id: event.id.uuidString, imageUrl: url, eventName: event.eventName,
                                    isOffline: event.isOffline, date: event.date, location: event.location,
                                    town: event.town, madeBy: event.madeBy, description: event.description,
                                    maximumPlaces: event.maximumPlaces, takenPlaces: 0, registrant: [UserDetails]())
    
    return eventCreated
  }
  
  /// This function take the user and turn into a restricted informations user
  private func packUserDetail(_ user: UserRegistered) -> UserDetails {
    
    let userDetails = UserDetails(id: user.id, pseudo: user.pseudo, name: user.name,
                           surname: user.surname, email: user.email, city: user.city,
                           profileImageUrl: user.profileImageUrl, isAdmin: user.isAdmin)
    
    return userDetails
  }
  
  /// This function check the device langage and return the object
  func packCenter(_ center: CenterRegistered) -> HelpCenter  {
    
    var helpCenter = HelpCenter(id: center.id!, name: center.name, phoneNumber: center.phoneNumber,
                                phoneNumberURL: URL(string: "tel://" + center.phoneNumber)!,
                                url: URL(string: center.url)!, description: "")
    
    let local = Locale.preferredLanguages[0]
    if local.hasPrefix("fr") {
      helpCenter.description = center.fr
    } else {
      helpCenter.description = center.en
    }
    return helpCenter
  }
}
