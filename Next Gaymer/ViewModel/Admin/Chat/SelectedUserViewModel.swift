//
//  SelectedUserViewModel.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 25/01/2022.
//

import SwiftUI

class SelectedUserViewModel: ObservableObject {

  @Published var selectedUser: UserDetailsAdmin
  
  init(selectedUser: UserDetailsAdmin) {
    self.selectedUser = selectedUser
  }
}

