//
//  SignInView.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 13/01/2022.
//

import SwiftUI

struct LoginView: View {

  @EnvironmentObject var viewRouter: ViewRouter
  @StateObject var loginModel = LoginViewModel()
    
  var body: some View {
    NavigationView {
      VStack(spacing: 15) {
        LogoView(width: 150, height: 150)
        Text("Next Gaymer")
          .font(.title)
        Spacer()
        LoginCredentials(email: $loginModel.email, password: $loginModel.password)
        if loginModel.requestStatus == .fail {
          NavigationLink(NSLocalizedString("forgetPassword", comment: "")) {
            ResetPasswordView()
          }
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.leading)
          .padding(.bottom)
        }
        Button {
          loginModel.loginUser()
        } label: {
          ButtonTextView(status: $loginModel.requestStatus,
                         text: NSLocalizedString("login", comment: ""))
        }
        .disabled(loginModel.disableButton())
        HStack {
          Button {
            loginModel.googleLoginUser()
          } label: {
            Image("Google Login")
              .resizable()
              .aspectRatio(contentMode: .fit)
              .frame(width: 200, height: 90, alignment: .center)
          }
        }
        Spacer()
        HStack {
          Text(NSLocalizedString("noAccount", comment: ""))
          NavigationLink {
            RegisterView()
          } label: {
            Text(NSLocalizedString("createAccount", comment: ""))
          }
        }
      }
      .padding()
      .alert(loginModel.errorMessage, isPresented: $loginModel.showAlert) {}
      .navigationBarHidden(true)
    }
    .onReceive(loginModel.$requestStatus) { newValue in
      if newValue == .success {
          viewRouter.currentPage = .loggedIn
      }
    }
  }
}

struct SignInView_Previews: PreviewProvider {
  static var previews: some View {
    LoginView()
  }
}
