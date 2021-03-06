//
//  AdminListUserViewModel.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 05/02/2022.
//

import Foundation
//
// MARK: - AdminList User VM
//

/// This class show to the user the list of the admin
class AdminListUserViewModel: ObservableObject {
  //
  // MARK: - Published Properties
  //
  @Published var adminList = [UserDetails]()
  @Published var errorMessage = ""
  @Published var showAlert = false
  
  //
  // MARK: - Initialization
  //
  init() {
    fetchAdminList()
  }
  
  //
  // MARK: - Private Method
  //
  /// Fetch the admin list with restricted details for the chat uses
  private func fetchAdminList() {
    DataManager.shared().fetchLimitedDetailAdminList { list, error in
      if let list = list {
        self.adminList = list
      } else {
        self.errorMessage = error ?? NSLocalizedString("failFetchAdminList", comment: "")
        self.showAlert.toggle()
      }
    }
  }
}
