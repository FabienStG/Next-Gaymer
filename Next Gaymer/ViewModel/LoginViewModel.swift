//
//  LoginViewModel.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 13/01/2022.
//

import SwiftUI
import Firebase
import GoogleSignIn

class LoginViewModel: ObservableObject  {
    
    // View Router
    @EnvironmentObject var viewRouter: ViewRouter

    // Info
    @Published var email = ""
    @Published var password = ""
    
    // Error handling
    @Published var errorMessage = ""
    @Published var showAlert = false
    @Published var showReset = false

    // Processing
    @Published var processing = false
        
    func loginUser() {
     
        processing = true
        DataManager.shared.loginUser { success in
            if success {
                withAnimation {
                    self.viewRouter.currentPage = .loggedIn
                }
                self.showReset = false
                self.processing = false
                self.logStatus = true
            } else {
                self.processing = false
                self.showReset = true
                self.showAlert.toggle()
            }
        }
    }
    
    func disableButton() -> Bool {
        return !processing && !email.isEmpty && !password.isEmpty ? false : true
    }
    
    func googleLoginUser() {
        
        processing = true
        DataManager.shared.googleLoginUser { success in
            if success {
                withAnimation {
                    self.viewRouter.currentPage = .loggedIn
                }
                self.processing = false
            } else {
                self.processing = false
                self.showAlert.toggle()
            }
        }
    }
}

