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
class UserListAdminViewModel: ObservableObject {
  //
  // MARK: - Published Properties
  //
  @Published var userList = [UserDetails]()
  @Published var errorMessage = ""
  @Published var showAlert = false
  
  //
  // MARK: - Initialization
  //
  init() {
    fetchUserList()
  }
  
  //
  // MARK: - Internal Method
  //
  /// This function fetch the users list
  func fetchUserList() {
    DataManager.shared().fetchlimitUsersDetailsAdmin { usersList, error in
      if let usersList = usersList {
        self.userList = usersList
      } else {
        self.errorMessage = error ?? NSLocalizedString("failFetchUserList", comment: "")
        self.showAlert.toggle()
      }
    }
  }
}
