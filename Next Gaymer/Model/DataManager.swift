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
    
    // Services
    var firebaseService = FirebaseSercice()
    
    
    func createUser(completionHandler: @escaping (Bool) -> Void) {
        firebaseService.createUser(userEmail: registerViewModel.email, userPassword: registerViewModel.password) { response, message in
            self.registerViewModel.errorMessage = message
            return completionHandler(response)
            }
    }
    
    func loginUser(completionHandler: @escaping(Bool) -> Void) {
        firebaseService.loginUser(userEmail: loginViewModel.email, userPassword: loginViewModel.password) { response, message in
            self.loginViewModel.errorMessage = message
            return completionHandler(response)
        }
    }
    
   func googleLoginUser(completionHandler: @escaping(Bool) -> Void) {
        firebaseService.googleLoginUser { response, message in
            self.loginViewModel.errorMessage = message
            return completionHandler(response)
        }
    }
    
    func logoutUser(completionHandler: @escaping(Bool) -> Void) {
        firebaseService.logoutUser { response, message in
            self.logoutViewModel.errorMessage = message
            return completionHandler(response)
        }
    }
}
