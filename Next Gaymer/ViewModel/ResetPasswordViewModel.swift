//
//  ResetPasswordViewModel.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 14/01/2022.
//

import SwiftUI

class ResetPasswordViewModel: ObservableObject{
    

    @Published var email = ""
    
    @Published var errorMessage = ""
    @Published var showAlert = false
    
    @Published var processing = false
    
    
    func resetPassword() {
        processing = true
        DataManager.shared.resetPassword(email: self.email) { success, message in
            if !success {
                self.errorMessage = message ?? "Erreur"
                self.showAlert.toggle()
            }
            self.processing = false
        }
    }
}


