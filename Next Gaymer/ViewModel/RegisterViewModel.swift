//
//  RegisterViewModel.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 14/01/2022.
//

import SwiftUI

class RegisterViewModel: ObservableObject {

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

  func registerUser() {

    let user = packUserDetail()

    requestStatus = .processing
    DataManager.shared.registerUser(with: user, password: password, image: profilImage) { success, message in

      if !success {
        self.errorMessage = message ?? "Erreur"
        self.showAlert.toggle()
        self.requestStatus = .fail
      } else {
        self.requestStatus = .success
      }
    }
  }

  func disableButton() -> Bool {
    return requestStatus != .initial && !email.isEmpty && !password.isEmpty && !confirmPassword.isEmpty && password == confirmPassword ? false : true
  }

func packUserDetail() -> UserDetailsForm {

  let user = UserDetailsForm(name: name, surname: surname, pseudo: pseudo, email: email, phoneNumber: phoneNumber, discordPseudo: discordPseudo, street: street, zipCode: zipCode, city: city)

  return user
  }
}
