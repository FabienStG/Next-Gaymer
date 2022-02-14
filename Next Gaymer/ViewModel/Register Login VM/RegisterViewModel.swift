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
  /// This function create the user, with the firestore profile and the authentifcation account
  func registerUser() {

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

  /// This disable the button when all the informations are not provided
  func disableButton() -> Bool {
    if name.isEmpty &&
       surname.isEmpty &&
       pseudo.isEmpty &&
       email.isEmpty &&
       phoneNumber.isEmpty &&
       discordPseudo.isEmpty &&
       street.isEmpty &&
       zipCode.isEmpty &&
       city.isEmpty &&
       password.isEmpty &&
       confirmPassword.isEmpty &&
       password != confirmPassword {
      print("false")
      return false
    } else {
      print("true")
      return true
    }
  }

  //
  // MARK: - Private Method
  //
  /// Turn the published var into an object use for the function
  private func packUserDetail() -> UserForm {
    
    let user = UserForm(name: name, surname: surname, pseudo: pseudo, email: email,
                        phoneNumber: phoneNumber, discordPseudo: discordPseudo,
                        street: street, zipCode: zipCode, city: city)
    
    return user
  }
}
