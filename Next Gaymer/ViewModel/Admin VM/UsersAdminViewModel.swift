//
//  NewMessageViewModel.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 22/01/2022.
//

import SwiftUI

class UsersAdminViewModel: ObservableObject {

  @Published var usersLimitedDetailsList = [UserDetails]()
  
  init() {
    fetchUserDetailsAdminList()
  }
    
  private func fetchUserDetailsAdminList() {
    DataManager.shared.fetchlimitUsersDetailsAdmin { usersList, error in
      if let usersList = usersList {
        self.usersLimitedDetailsList = usersList
      } else {
        print(error ?? "Failed to fetch list")
      }
    }
  }
}
