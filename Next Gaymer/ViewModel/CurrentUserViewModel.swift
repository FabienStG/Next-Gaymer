//
//  CurrentUserViewModel.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 22/01/2022.
//

import SwiftUI

class CurrentUserViewModel: ObservableObject {

  @Published var currentUser: UserRegistered?
  @Published var errorMessage = ""
  
  @Published var showAlert = false
  
  init() {
    fetchCurrentUser()
  }
  
  private func fetchCurrentUser() {
    DataManager.shared.fetchCurrentUser { user, error in
      if let user = user {
        self.currentUser = user
      } else {
        self.errorMessage = error ?? "Impossible de récupérer l'utilisateur"
      }
    }
  }
}
