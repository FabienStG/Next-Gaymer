//
//  SignInView.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 13/01/2022.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var loginModel = LoginViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 15) {
                LogoView()
                Spacer()
                SignInCredentials(email: $loginModel.email, password: $loginModel.password)
                Button {
                    loginModel.loginUser()
                } label: {
                    ButtonTextView(bool: $loginModel.processing, text: "Se connecter")
                }
                .disabled(loginModel.disableButton())
                HStack {
                    Button {
                        loginModel.googleLoginUser()
                    } label: {
                        Image("Google Login")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200, height: 70, alignment: .center)
                    }
                }
                Spacer()
                HStack {
                    Text("Pas de compte ?")
                    NavigationLink {
                        RegisterView()
                    } label: {
                        Text("Créez un compte")
                    }
                }
            }
            .padding()
            .alert(loginModel.errorMessage, isPresented: $loginModel.showAlert) {}
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

