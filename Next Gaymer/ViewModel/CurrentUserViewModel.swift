//
//  CurrentUserViewModel.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 22/01/2022.
//

import SwiftUI
//
// MARK: - Current User VM
//

/// This class is initialize when the user is login and save for the life cycle of the App and provite the info into all the views
class CurrentUserViewModel: ObservableObject {
  //
  // MARK: - Published Properties
  //
  @Published var currentUser: UserRegistered?
  @Published var errorMessage = ""
  @Published var showAlert = false
  
  //
  // MARK: - Initialization
  //
  init() {
    fetchCurrentUser()
  }
  
  //
  // MARK: - Private Method
  //
  func fetchCurrentUser() {
    DataManager.shared.fetchCurrentUser { user, error in
      if let user = user {
        self.currentUser = user
      } else {
        self.errorMessage = error ?? NSLocalizedString("failFindUser", comment: "")
      }
    }
  }
}
