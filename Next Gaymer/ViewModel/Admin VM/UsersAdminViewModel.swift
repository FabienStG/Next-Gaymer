//
//  NewMessageViewModel.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 22/01/2022.
//

import SwiftUI
//
// MARK: - User Admin VM
//

/// This class used by the admin users to fetch the user's list
class UsersAdminViewModel: ObservableObject {
  //
  // MARK: - Published Properties
  //
  @Published var usersLimitedDetailsList = [UserDetails]()
  @Published var errorMessage = ""
  @Published var showAlert = false
  
  //
  // MARK: - Initialization
  //
  init() {
    fetchUserDetailsAdminList()
  }
  
  //
  // MARK: - Private Method
  //
  /// This function fetch the users list
  private func fetchUserDetailsAdminList() {
    DataManager.shared.fetchlimitUsersDetailsAdmin { usersList, error in
      if let usersList = usersList {
        self.usersLimitedDetailsList = usersList
      } else {
        self.errorMessage = error ?? NSLocalizedString("failFetchUserList", comment: "")
      }
    }
  }
}
