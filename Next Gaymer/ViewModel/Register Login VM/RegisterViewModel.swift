//
//  RegisterViewModel.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 14/01/2022.
//

import SwiftUI
//
// MARK: - Register VM
//

/// This class manage the user entry when the profile is created
class RegisterViewModel: ObservableObject {
  //
  // MARK: - Published Properties
  //
  @Published var profilImage = UIImage()
  @Published var name = ""
  @Published var surname = ""
  @Published var pseudo = ""
  @Published var email = ""
  @Published var phoneNumber = ""
  @Published var discordPseudo = ""
  @Published var street = ""
  @Published var zipCode = ""
  @Published var city = ""

  @Published var password = ""
  @Published var confirmPassword = ""

  @Published var errorMessage = ""
  @Published var showAlert = false

  @Published var requestStatus: RequestStatus = .initial

  @Published var changeProfileImage = false
  @Published var openCameraRool = false

  //
  // MARK: - Internal Method
  //
  /// This function check if the form is complete and register the user
  func registerUserButton() {

    if checkProfile() {
      registrateUser()
    }
  }

  /// This disable the button when the minimum informations are not provided
  func disableButton() -> Bool {
    return !email.isEmpty && !password.isEmpty && password == confirmPassword
  }
  //
  // MARK: - Private Method
  //
  /// Turn the published var into an object use for the function
  private func packUserDetail() -> UserForm {
    
    checkImage()
    
    let user = UserForm(name: name, surname: surname, pseudo: pseudo, email: email,
                        phoneNumber: phoneNumber, discordPseudo: discordPseudo,
                        street: street, zipCode: zipCode, city: city)
    
    return user
  }
  
  /// Check if the image is usable then use a specific one
  private func checkImage() {
    if profilImage.size.width == 0 {
      profilImage = UIImage(systemName: "person.circle.fill")!
    }
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
  
  /// This function create the user, with the firestore profile and the authentifcation account
  private func registrateUser() {

    requestStatus = .processing
    DataManager.shared().registerUser(
      with: packUserDetail(), password: password,
      image: profilImage) { success, message in

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
