//
//  UserDetailsAdminViewModel.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 23/01/2022.
//

import SwiftUI
//
// MARK: - UserDetails Admin VM
//

/// This class show to the admin the selected user details with only informations accessible by default.
class UserDetailsAdminViewModel: ObservableObject {
  //
  // MARK: - Published Proterties
  //
  @Published var selectedUser: UserDetails
  @Published var confirmationMessage = ""
  @Published var presentConfirmation = false
  @Published var presentAlert = false
  
  @Published var requestStatus: RequestStatus = .initial
  
  //
  // MARK: - Initialization
  //
  init(selectedUser: UserDetails) {
    self.selectedUser = selectedUser
  }
  
  //
  // MARK: - Internal Methods
  //
  /// This function change the user profile admin to true, and by this, give him the admin access to the app
  func setUserAdminCrentials() {
    
    DataManager.shared().setUserAdminCredentials(userId: selectedUser.id) { message in
      self.confirmationMessage = message
      self.presentAlert.toggle()
    }
  }
  
}
