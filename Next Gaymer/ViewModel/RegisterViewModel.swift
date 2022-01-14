//
//  RegisterViewModel.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 14/01/2022.
//

import SwiftUI
import Firebase

class RegisterViewModel: ObservableObject {

    // View Router
    @EnvironmentObject var viewRouter: ViewRouter
    
    // Info
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    
    // Error handling
    @Published var errorMessage = ""
    @Published var showAlert = false
    
    // Processing
    @Published var processing = false
    
    func createUser() {
        
        processing = true
        DataManager.shared.createUser { success in
            
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
    
    func disableButton() -> Bool {
        return !processing && !email.isEmpty && !password.isEmpty && !confirmPassword.isEmpty && password == confirmPassword ? false : true
    }
}
