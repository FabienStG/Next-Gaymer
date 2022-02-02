//
//  LoginViewModel.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 13/01/2022.
//

import SwiftUI

class LoginViewModel: ObservableObject  {

  @Published var email = ""
  @Published var password = ""

  @Published var errorMessage = ""
  @Published var showAlert = false
  @Published var showReset = false

  @Published var requestStatus: RequestStatus = .initial

  func loginUser() {

    requestStatus = .processing
    DataManager.shared.loginUser(email: self.email, password: self.password) { success, message in
      if !success {
        self.errorMessage = message ?? NSLocalizedString("unknownError", comment: "")
        self.showReset = true
        self.showAlert.toggle()
        self.requestStatus = .fail
      } else {
        self.requestStatus = .success
      }
    }
  }

  func disableButton() -> Bool {
    return requestStatus != .processing && !email.isEmpty && !password.isEmpty ? false : true
  }

  func googleLoginUser() {

    requestStatus = .processing
    DataManager.shared.googleLoginUser { success, message in
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
