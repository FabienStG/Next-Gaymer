//
//  GoogleRegisterViewModel.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 10/02/2022.
//

import SwiftUI
//
// MARK: - GoogleRegister View Model
//

/// This class is inherited from RegisterModel, with the specific information from the google signin function
class GoogleRegisterViewModel: RegisterViewModel {
  //
  // MARK: - Private Properties
  //
  private var userId = ""
  private var imageUrl = ""
  
  //
  // MARK: - Override Initialization
  //
  override init() {
    super.init()
    setGoogleFormInfo { userInfo in
      self.name = userInfo[UserConstant.name]!
      self.userId = userInfo[UserConstant.name]!
      self.phoneNumber = userInfo[UserConstant.phoneNumber]!
      self.email = userInfo[UserConstant.email]!
      self.imageUrl = userInfo[UserConstant.profileImageUrl]!
    }
  }
  
  //
  // MARK: - Override Method
  //
  /// Override the mother class register button with is own function
  override func registerUserButton() {
    if checkProfile() {
      registrateUser()
    }
  }
  
  //
  // MARK: - Private Method
  //
  /// Check the google info and provide the form with it
  private func setGoogleFormInfo(completionHandler: @escaping([String: String]) -> Void) {
    DataManager.shared().fetchGoogleUserInfo { userInfo in
      return completionHandler(userInfo)
    }
  }
  
  /// Turn the published var into an object use for the function
  private func packUserDetail() -> UserRegistered {
    
    let user = UserRegistered(id: userId, name: name, surname: surname, pseudo: pseudo,
                              profileImageUrl: imageUrl, email: email, phoneNumber: phoneNumber,
                              discordPseudo: discordPseudo, street: street, zipCode: zipCode,
                              city: city, isAdmin: false, myEvent: [])
    
    return user
  }
  
  /// Check is the form is empty
  private func checkProfile() -> Bool {
    if name.isEmpty ||
        surname.isEmpty ||
        pseudo.isEmpty ||
        phoneNumber.isEmpty ||
        discordPseudo.isEmpty ||
        street.isEmpty ||
        zipCode.isEmpty ||
        city.isEmpty
    {
      errorMessage = NSLocalizedString("emptyForm", comment: "")
      showAlert.toggle()
      return false
    }
    return true
  }
  
  /// Try to register the google user as an app one
  private func registrateUser() {
    
    requestStatus = .processing
    DataManager.shared().registerGoogleUser(
      with: packUserDetail()) { success, message in
        
        if !success {
          self.errorMessage = message ?? NSLocalizedString("unknownError", comment: "")
          self.showAlert.toggle()
          self.requestStatus = .fail
        } else {
          self.requestStatus = .success
        }
      }
  }
}

