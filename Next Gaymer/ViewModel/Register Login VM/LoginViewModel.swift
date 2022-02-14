//
//  LoginViewModel.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 13/01/2022.
//

import SwiftUI
//
// MARK: - Login VM
//

/// The login VM class take the credentials of the user and check with
/// the DataManager. It also manage the reset password view.
class LoginViewModel: ObservableObject  {
  //
  // MARK: - Published Properties
  //
  @Published var email = ""
  @Published var password = ""

  @Published var errorMessage = ""
  @Published var showAlert = false
  @Published var showReset = false

  @Published var showGoogleForm = false
  @Published var requestStatus: RequestStatus = .initial

  //
  // MARK: - Internal Methods
  //
  /// Disable the login button
  func disableButton() -> Bool {
    return requestStatus != .processing && !email.isEmpty && !password.isEmpty ? false : true
  }
  
  /// This function log the user
  func loginUser() {

    requestStatus = .processing
    DataManager.shared().loginUser(email: self.email, password: self.password) { success, message in
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
  
  /// This function is called when the Google SignIn button is use
  func googleLoginUser() {

    requestStatus = .processing
    DataManager.shared().googleLoginUser { success, message in
      if !success {
        self.errorMessage = message ?? NSLocalizedString("unknownError", comment: "")
        self.showAlert.toggle()
        self.requestStatus = .fail
      } else {
        self.showGoogleForm = true
      }
    }
  }
}
