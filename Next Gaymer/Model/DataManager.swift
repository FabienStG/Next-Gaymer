//
//  DataManager.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 14/01/2022.
//

import Foundation
import SwiftUI
import GoogleSignIn
import Firebase

class DataManager {
    
    // Singleton
    static let shared = DataManager()
    
    private init() {}
    
    // View Model
    var loginViewModel = LoginViewModel()
    var registerViewModel = RegisterViewModel()
    var logoutViewModel = LogoutViewModel()
    var resetPasswordViewModel = ResetPasswordViewModel()
    
    // Services
    var firebaseService = FirebaseSercice()
    
    // Log Storage
    @AppStorage("log_status") var logStatus = false
        
    
    func createUser(completionHandler: @escaping (Bool) -> Void) {
        firebaseService.createUser(userEmail: registerViewModel.email, userPassword: registerViewModel.password) { response, message in
            if response {
                self.logStatus = true
            }
            self.registerViewModel.errorMessage = message
            return completionHandler(response)
            }
    }
    
    func loginUser(completionHandler: @escaping(Bool) -> Void) {
        firebaseService.loginUser(userEmail: loginViewModel.email, userPassword: loginViewModel.password) { response, message in
            if response {
                self.logStatus = true
            }
            self.loginViewModel.errorMessage = message
            return completionHandler(response)
        }
    }
    
   func googleLoginUser(completionHandler: @escaping(Bool) -> Void) {
        firebaseService.googleLoginUser { response, message in
            if response {
                self.logStatus = true
            }
            self.loginViewModel.errorMessage = message
            return completionHandler(response)
        }
    }
    
    func logoutUser(completionHandler: @escaping(Bool) -> Void) {
        firebaseService.logoutUser { response, message in
            if response {
                self.logStatus = false
            }
            self.logoutViewModel.errorMessage = message
            return completionHandler(response)
        }
    }
    
    func resetPassword(completionHandler: @escaping(Bool) -> Void) {
        firebaseService.resetPassword(emailUser: resetPasswordViewModel.email) { response, message in
            self.resetPasswordViewModel.errorMessage = message
            return completionHandler(response)
        }
    }
}
