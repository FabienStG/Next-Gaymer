//
//  LoginViewModel.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 13/01/2022.
//

import SwiftUI

class LoginViewModel: ObservableObject  {
    
    // Info
    @Published var email = ""
    @Published var password = ""
    
    // Error handling
    @Published var errorMessage = ""
    @Published var showAlert = false
    @Published var showReset = false

    // Processing
    @Published var requestStatus: RequestStatus = .initial
    
    func loginUser() {
     
        requestStatus = .processing
        DataManager.shared.loginUser(email: self.email, password: self.password) { success, message in
            if !success {
                self.errorMessage = message ?? "Erreur"
                self.showReset = true
                self.showAlert.toggle()
                self.requestStatus = .fail
            } else {
                self.requestStatus = .success
            }
        }
    }
    
    func disableButton() -> Bool {
        return requestStatus != .processing && !email.isEmpty && !password.isEmpty ? false : true
    }
    
    func googleLoginUser() {
        
        requestStatus = .processing
        DataManager.shared.googleLoginUser { success, message in
            if !success {
                self.errorMessage = message ?? "Erreur"
                self.showAlert.toggle()
                self.requestStatus = .fail
            } else {
                self.requestStatus = .success
            }
        }
    }
}

enum RequestStatus {
    
    case initial
    case processing
    case success
    case fail
    
}
