//
//  NewMessageViewModel.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 22/01/2022.
//

import SwiftUI

class UsersAdminViewModel: ObservableObject {

  @Published var usersLimitedDetailsList = [UserDetails]()
  
  @Published var errorMessage = ""
  @Published var showAlert = false
  
  init() {
    fetchUserDetailsAdminList()
  }
    
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
