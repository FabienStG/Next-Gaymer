//
//  logoutViewModel.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 14/01/2022.
//

import SwiftUI
//
// MARK: - Logout ViewModel
//

/// This class call the manager to log out the user
class ProfileViewModel: ObservableObject {
  //
  // MARK: - Published Properties
  //
  @Published var errorMessage = ""
  @Published var showAlert = false

  @Published var requestStatus: RequestStatus = .initial
  
  @Published var name = ""
  @Published var surname = ""
  @Published var pseudo = ""
  @Published var email = ""
  @Published var phoneNumber = ""
  @Published var discordPseudo = ""
  @Published var street = ""
  @Published var zipCode = ""
  @Published var city = ""
  
  @Published var disableModification = true
  @Published var showReauthentification = false
  @Published var updateComplete = false
  @Published var showConfirmation = false

  //
  // MARK: - Internal Method
  //
  /// Logout the user
  func logoutUser() {

    requestStatus = .processing
    DataManager.shared().logoutUser { success, message in
      if !success {
        self.requestStatus = .fail
        self.errorMessage = message ?? NSLocalizedString("unkownError", comment: "")
        self.showAlert.toggle()
      } else {
        self.requestStatus = .success
      }
    }
  }
  
  /// Enable modification on the profile
  func modifyProfile(user: UserRegistered) {
    updateComplete = false
    disableModification = false
    name = user.name
    surname = user.surname
    pseudo = user.pseudo
    phoneNumber = user.phoneNumber
    discordPseudo = user.discordPseudo
    street = user.street
    zipCode = user.zipCode
    city = user.city
  }
  
  /// Send the modifications to firebase
  func validateModifications() {
    
    DataManager.shared().updateUserInfo(userInfo: packUserInfo()) { response, error in
      if !response {
        self.errorMessage = error ?? NSLocalizedString("unkownError", comment: "")
      } else {
        self.errorMessage = NSLocalizedString("modificationComplete", comment: "")
        self.disableModification = true
        self.updateComplete = true
      }
      self.showAlert.toggle()
    }
  }
  
  //
  // MARK: - Private Method
  //
  /// Take all the form and packed into an object saved for firebase
  private func packUserInfo() -> [String: Any] {
    
    let userPacked = [
      UserConstant.name: name,
      UserConstant.surname: surname,
      UserConstant.pseudo: pseudo,
      UserConstant.phoneNumber: phoneNumber,
      UserConstant.discordPseudo: discordPseudo,
      UserConstant.street: street,
      UserConstant.zipCode: zipCode,
      UserConstant.city: city
    ]
    return userPacked
  }
}
