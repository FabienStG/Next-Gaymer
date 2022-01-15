//
//  logoutViewModel.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 14/01/2022.
//

import SwiftUI

class LogoutViewModel: ObservableObject {

    // Error Handler
    @State var errorMessage = ""
    @State var showAlert = false
    
    // Processing
    @State var processing = false
    
    func logoutUser(completionHandler: @escaping(Bool) -> Void) {
        
        processing = true
        DataManager.shared.logoutUser { success, message in
            if !success {
                self.processing = false
                self.errorMessage = message ?? "Erreur"
                self.showAlert.toggle()
                return completionHandler(success)
            }
            self.processing = false
            return completionHandler(success)
        }
    }
}

