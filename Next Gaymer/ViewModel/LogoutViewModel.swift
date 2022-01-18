//
//  logoutViewModel.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 14/01/2022.
//

import SwiftUI

class LogoutViewModel: ObservableObject {

    // Error Handler
    @Published var errorMessage = ""
    @Published var showAlert = false
    
    // Processing
    @Published var requestStatus: RequestStatus = .initial
    
    func logoutUser() {
        
        requestStatus = .processing
        DataManager.shared.logoutUser { success, message in
            if !success {
                self.requestStatus = .fail
                self.errorMessage = message ?? "Erreur"
                self.showAlert.toggle()
            } else {
                self.requestStatus = .success
            }
        }
    }
}

