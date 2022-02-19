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
class LogoutViewModel: ObservableObject {
  //
  // MARK: - Published Properties
  //
  @Published var errorMessage = ""
  @Published var showAlert = false

  @Published var requestStatus: RequestStatus = .initial

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
}
