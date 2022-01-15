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
    @Published var processing = false
    
    func loginUser(completionHandler: @escaping(Bool) -> Void) {
     
        processing = true
        DataManager.shared.loginUser(email: self.email, password: self.password) { success, message in
            if !success {
                self.errorMessage = message ?? "Erreur"
                self.showReset = true
                self.showAlert.toggle()
                self.processing = false
                return completionHandler(success)
            } else {
                self.showReset = false
            }
            self.processing = false
            return completionHandler(success)
        }
    }
    
    func disableButton() -> Bool {
        return !processing && !email.isEmpty && !password.isEmpty ? false : true
    }
    
    func googleLoginUser(completionHandler: @escaping(Bool) -> Void) {
        
        processing = true
        DataManager.shared.googleLoginUser { success, message in
            if !success {
                self.errorMessage = message ?? "Erreur"
                self.showAlert.toggle()
                self.processing = false
                return completionHandler(success)
            }
            self.processing = false
            return completionHandler(success)
        }
    }
}

