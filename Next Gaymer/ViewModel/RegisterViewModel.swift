//
//  RegisterViewModel.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 14/01/2022.
//

import SwiftUI

class RegisterViewModel: ObservableObject {

    // View Router
    @EnvironmentObject var viewRouter: ViewRouter
    
    // Info
    @Published var name = ""
    @Published var surname = ""
    @Published var email = ""
    @Published var phoneNumber = ""
    @Published var street = ""
    @Published var zipCode = ""
    @Published var city = ""
    
    @Published var password = ""
    @Published var confirmPassword = ""
    
    // Error handling
    @Published var errorMessage = ""
    @Published var showAlert = false
    
    // Processing
    @Published var processing = false
    
    func registerUser() {
        
        processing = true
        DataManager.shared.registerUser { success in
            
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
