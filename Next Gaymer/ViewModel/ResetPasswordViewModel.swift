//
//  ResetPasswordViewModel.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 14/01/2022.
//

import SwiftUI

class ResetPasswordViewModel: ObservableObject{

  @Published var email = ""
  @Published var errorMessage = ""
  @Published var showAlert = false

  @Published var requestStatus: RequestStatus = .initial

  func resetPassword() {
    requestStatus = .processing
    DataManager.shared.resetPassword(email: self.email) { success, message in
      if !success {
        self.errorMessage = message ?? "Erreur"
        self.showAlert.toggle()
      }
      self.requestStatus = .initial
    }
  }
}
