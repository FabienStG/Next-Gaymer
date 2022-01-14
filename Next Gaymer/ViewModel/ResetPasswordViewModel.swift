//
//  ResetPasswordViewModel.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 14/01/2022.
//

import SwiftUI

class ResetPasswordViewModel: ObservableObject{
    
    @EnvironmentObject var viewRouter: ViewRouter

    @Published var email = ""
    
    @Published var errorMessage = ""
    @Published var showAlert = false
    
    @Published var processing = false
    
    
    func resetPassword() {
        processing = true
        DataManager.shared.resetPassword { success in
            if success {
                withAnimation {
                    self.viewRouter.currentPage = .loggedOut
                }
                self.processing = false
            } else {
                self.processing = false
                self.showAlert.toggle()
            }
        }
    }
}


