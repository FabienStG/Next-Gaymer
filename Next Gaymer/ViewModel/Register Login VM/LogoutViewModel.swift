//
//  logoutViewModel.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 14/01/2022.
//

import SwiftUI

class LogoutViewModel: ObservableObject {

  @Published var errorMessage = ""
  @Published var showAlert = false

  @Published var requestStatus: RequestStatus = .initial

  func logoutUser() {

    requestStatus = .processing
    DataManager.shared.logoutUser { success, message in
      if !success {
        self.requestStatus = .fail
        self.errorMessage = message ?? NSLocalizedString("unkownError", comment: "")
        self.showAlert.toggle()
      } else {
        self.requestStatus = .success
      }
    }
  }
}
