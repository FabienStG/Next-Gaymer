//
//  RegisterViewModel.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 14/01/2022.
//

import SwiftUI

class RegisterViewModel: ObservableObject {


    
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
    
    func registerUser(completionHandler: @escaping (Bool) -> Void ) {
        
        let user = packUserDetail()
        
        processing = true
        DataManager.shared.registerUser(with: user) { success, message in
            
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
    
    func disableButton() -> Bool {
        return !processing && !email.isEmpty && !password.isEmpty && !confirmPassword.isEmpty && password == confirmPassword ? false : true
    }
    
    func packUserDetail() -> UserDetails {
        
        let user = UserDetails(name: self.name, surname: self.surname,
                               email: self.email, phoneNumber: self.phoneNumber,
                               street: self.street, zipCode: self.zipCode,
                               city: self.city, password: self.password)
        
        return user
    }
}
