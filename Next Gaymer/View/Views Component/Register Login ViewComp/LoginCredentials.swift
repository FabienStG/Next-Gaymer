//
//  SignInCredentials.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 13/01/2022.
//

import SwiftUI

struct LoginCredentials: View {

  @Binding var email: String
  @Binding var password: String

  var body: some View {
    VStack {
      Group {
        EmailView(email: $email)
        SecureField(NSLocalizedString("password", comment: ""), text: $password)
          .padding()
          .textInputAutocapitalization(.never)
          .background(.thinMaterial)
          .cornerRadius(10)
      }
    }
  }
}

struct SignInCredentials_Previews: PreviewProvider {
  static var previews: some View {
    LoginCredentials(email: .constant(""), password: .constant(""))
  }
}
