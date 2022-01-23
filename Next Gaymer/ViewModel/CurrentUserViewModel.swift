//
//  CurrentUserViewModel.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 22/01/2022.
//

import SwiftUI

class CurrentUserViewModel: ObservableObject {

  @Published var currentUser: UserRegistered?
  
  init() {
    fetchCurrentUser()
  }
  
  private func fetchCurrentUser() {
    print("Fetching current User")
    DataManager.shared.fetchCurrentUser { user, error in
      if let user = user {
        self.currentUser = user
      }
    }
  }
}
