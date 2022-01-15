//
//  logoutViewModel.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 14/01/2022.
//

import SwiftUI

class LogoutViewModel: ObservableObject {
    
    // View Routeur
    @EnvironmentObject var viewRouter: ViewRouter

    // Error Handler
    @State var errorMessage = ""
    @State var showAlert = false
    
    // Processing
    @State var processing = false
    
    func logoutUser() {
        
        processing = true
        DataManager.shared.logoutUser { success in
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
