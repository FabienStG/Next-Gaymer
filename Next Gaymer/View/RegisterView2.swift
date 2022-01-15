//
//  SignUpView.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 13/01/2022.
//

import SwiftUI

struct RegisterView2: View {
        
    @StateObject var registerModel = RegisterViewModel()
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        VStack(spacing: 15) {
            LogoView()
            Text("Connexion")
                .font(.largeTitle)
            Spacer()
            RegisterCredentials(email: $registerModel.email, password: $registerModel.password, passwordConfirmation: $registerModel.confirmPassword)
            Button {
                registerModel.registerUser { succes in
                    if succes {
                        withAnimation {
                            viewRouter.currentPage = .loggedIn
                        }
                    }
                }
            } label: {
                ButtonTextView(bool: $registerModel.processing, text: "Créer un compte")
            }
            .disabled(registerModel.disableButton())
            Spacer()
        }
        .alert(registerModel.errorMessage, isPresented: $registerModel.showAlert) {}
        .padding()
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView2()
    }
}
