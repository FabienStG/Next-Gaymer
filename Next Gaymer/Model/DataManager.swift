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
    
    // Services
    var firebaseService = FirebaseService()
    
    // Log Storage
    @AppStorage("log_status") var logStatus = false
        
    func registerUser(with user: UserDetails, completionHandler: @escaping(Bool, String?) -> Void) {
        
        firebaseService.createUser(userEmail: user.email, userPassword: user.password) { response, authMessage in
            if response {
                self.firebaseService.registrateUser(with: user) { response, dbMessage in
                    if response {
                        self.logStatus = true
                        return completionHandler(true, nil)
                    } else {
                        return completionHandler(false, dbMessage)
                    }
                }
            } else {
                return completionHandler(false, authMessage)
            }
        }
    }
    
    func loginUser(email: String, password: String, completionHandler: @escaping(Bool, String?) -> Void) {
        firebaseService.loginUser(userEmail: email, userPassword: password) { response, message in
            if response {
                self.logStatus = true
                return completionHandler(response, nil)
            } else {
                return completionHandler(response, message)
            }
        }
    }
    
   func googleLoginUser(completionHandler: @escaping(Bool, String?) -> Void) {
        firebaseService.googleLoginUser { response, message in
            if response {
                self.logStatus = true
                return completionHandler(response, nil)
            } else {
               return completionHandler(response, message)
            }
        }
    }
    
    func logoutUser(completionHandler: @escaping(Bool, String?) -> Void) {
        firebaseService.logoutUser { response, message in
            if response {
                self.logStatus = false
                return completionHandler(response, nil)
            } else {
                return completionHandler(response, message)
            }
        }
    }
    
    func resetPassword(email: String, completionHandler: @escaping(Bool, String?) -> Void) {
        firebaseService.resetPassword(emailUser: email) { response, message in
            if !response {
                return completionHandler(response, message)
            }
            return completionHandler(response, nil)
        }
    }
    
}
