//
//  SelectedUserViewModel.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 25/01/2022.
//

import SwiftUI
//
// MARK: - Selected User VM
//

/// This class provide a limited number of info from a selected user
class SelectedUserViewModel: ObservableObject {
  //
  // MARK: - Published Propertie
  //
  @Published var selectedUser: UserDetails
  
  //
  // MARK: - Initialization
  //
  init(selectedUser: UserDetails) {
    self.selectedUser = selectedUser
  }
}

