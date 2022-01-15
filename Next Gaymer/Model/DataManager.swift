//
//  DataManager.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 14/01/2022.
//

import Foundation
import SwiftUI

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
    var firebaseService = FirebaseService()
    
    // Log Storage
    @AppStorage("log_status") var logStatus = false
        
    
  /*  func createUser(completionHandler: @escaping (Bool) -> Void) {
        firebaseService.createUser(userEmail: registerViewModel.email, userPassword: registerViewModel.password) { response, message in
            if response {
                self.logStatus = true
            } else {
                self.registerViewModel.errorMessage = message!
            }
            return completionHandler(response)
        }
    }
    
    func registrateUser(completionHandler: @escaping(Bool) -> Void) {
        firebaseService.registrateUser(with: packUserDetail()) { response, message in
            if response {
                self.logStatus = true
            } else {
                self.registerViewModel.errorMessage = message!
            }
            return completionHandler(response)
        }
    }*/
    
    func registerUser(completionHandler: @escaping(Bool) -> Void) {
        
        let user = packUserDetail()
        
        firebaseService.createUser(userEmail: user.email, userPassword: user.password) { response, authMessage in
            if response {
                self.firebaseService.registrateUser(with: user) { response, dbMessage in
                    if response {
                        self.logStatus = true
                        return completionHandler(true)
                    } else {
                        self.registerViewModel.errorMessage = dbMessage!
                        return completionHandler(false)
                    }
                }
            } else {
                self.registerViewModel.errorMessage = authMessage!
                return completionHandler(false)
            }
        }
    }
    
    func loginUser(completionHandler: @escaping(Bool) -> Void) {
        firebaseService.loginUser(userEmail: loginViewModel.email, userPassword: loginViewModel.password) { response, message in
            if response {
                self.logStatus = true
            } else {
                self.loginViewModel.errorMessage = message!
            }
            return completionHandler(response)
        }
    }
    
   func googleLoginUser(completionHandler: @escaping(Bool) -> Void) {
        firebaseService.googleLoginUser { response, message in
            if response {
                self.logStatus = true
            } else {
                self.loginViewModel.errorMessage = message
            }
            return completionHandler(response)
        }
    }
    
    func logoutUser(completionHandler: @escaping(Bool) -> Void) {
        firebaseService.logoutUser { response, message in
            if response {
                self.logStatus = false
            } else {
                self.logoutViewModel.errorMessage = message!
            }
            return completionHandler(response)
        }
    }
    
    func resetPassword(completionHandler: @escaping(Bool) -> Void) {
        firebaseService.resetPassword(emailUser: resetPasswordViewModel.email) { response, message in
            if !response {
                self.resetPasswordViewModel.errorMessage = message!
            }
            return completionHandler(response)
        }
    }
    
    func packUserDetail() -> UserDetails {
        
        let user = UserDetails(name: registerViewModel.name, surname: registerViewModel.surname,
                               email: registerViewModel.email, phoneNumber: registerViewModel.phoneNumber,
                               street: registerViewModel.street, zipCode: registerViewModel.zipCode,
                               city: registerViewModel.city, password: registerViewModel.password)
        print(user)
        
        return user
    }
}
