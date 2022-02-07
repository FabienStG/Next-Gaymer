//
//  ResetPasswordViewModel.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 14/01/2022.
//

import SwiftUI
//
// MARK: - Reset Password VM
//

/// This class is the reset password function
class ResetPasswordViewModel: ObservableObject{
  //
  // MARK: - Published Properties
  //
  @Published var email = ""
  @Published var errorMessage = ""
  @Published var showAlert = false

  @Published var requestStatus: RequestStatus = .initial

  //
  // MARK: - Internal Method
  //
  /// Reset the user password by sending a mail
  func resetPassword() {
    requestStatus = .processing
    DataManager.shared.resetPassword(email: self.email) { success, message in
      if !success {
        self.errorMessage = message ?? NSLocalizedString("unkownError", comment: "")
        self.showAlert.toggle()
      }
      self.requestStatus = .initial
    }
  }
}
