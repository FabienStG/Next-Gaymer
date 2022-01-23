//
//  UserDetailsAdminViewModel.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 23/01/2022.
//

import SwiftUI

class UserDetailsAdminViewModel: ObservableObject {
  
  @Published var selectedUser: UserDetailsAdmin
  
  init(selectedUser: UserDetailsAdmin) {
    self.selectedUser = selectedUser
  }
  
}
