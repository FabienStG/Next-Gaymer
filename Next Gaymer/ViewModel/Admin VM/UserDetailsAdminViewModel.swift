//
//  UserDetailsAdminViewModel.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 23/01/2022.
//

import SwiftUI

class UserDetailsAdminViewModel: ObservableObject {
  
  @Published var selectedUser: UserDetails
  @Published var confirmationMessage = ""
  @Published var presentConfirmation = false
  @Published var presentAlert = false
  
  init(selectedUser: UserDetails) {
    self.selectedUser = selectedUser
  }
  
  func setUserAdminCrentials() {
    
    DataManager.shared.setUserAdminCredentials(userId: selectedUser.id) { message in
      self.confirmationMessage = message
      self.presentAlert.toggle()
    }
  }
  
}
