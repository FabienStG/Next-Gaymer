//
//  ProfileManagementViewModel.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 19/02/2022.
//

import SwiftUI
//
// MARK: - ConfirmationDelete View Model
//

/// This class reauthenticate the user for validation and delete all data store in firebase
class ConfirmationDeleteViewModel: ObservableObject {
  //
  // MARK: - Published Properties
  //
  @Published var email = ""
  @Published var password = ""
  
  @Published var errorMessage = ""
  @Published var showAlert = false
  
  @Published var requestStatus: RequestStatus = .initial
  
  //
  // MARK: - Internal Method
  //
  /// This function reauthenticate the user and delete him
  func reauthenticateUser() {
    
    DataManager.shared().reauthenticateUser(email: email, password: password) { response, error in
      self.requestStatus = .processing
      if !response {
        self.errorMessage = error ?? NSLocalizedString("unknownError", comment: "")
        self.showAlert = true
        self.requestStatus = .fail
      } else if response {
        self.deleteUser()
      }
    }
  }
  
  //
  // MARK: - Private Method
  //
  /// This function is called when the authentification work and delete the user data
  private func deleteUser() {
    
    DataManager.shared().deleteUser { result, error in
      if !result {
        self.errorMessage = error ?? NSLocalizedString("unkownError", comment: "")
        self.showAlert = true
        self.requestStatus = .fail
      } else {
        self.requestStatus = .success
      }
    }
  }
}
