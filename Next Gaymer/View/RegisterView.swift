//
//  SignUpView.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 13/01/2022.
//

import SwiftUI

struct RegisterView: View {
        
    @StateObject var registerModel = RegisterViewModel()
    var body: some View {
        VStack(spacing: 15) {
            LogoView()
            Text("Connexion")
                .font(.largeTitle)
            Spacer()
            SignUpCredentials(email: $registerModel.email, password: $registerModel.password, passwordConfirmation: $registerModel.confirmPassword)
            Button {
                registerModel.createUser()
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
        RegisterView()
    }
}
