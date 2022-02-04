//
//  SignUpCredentials.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 13/01/2022.
//

import SwiftUI

struct RegisterCredentials: View {

  @Binding var email: String
  @Binding var password: String
  @Binding var passwordConfirmation: String

  var body: some View {
    VStack {
      Group{
        EmailView(email: $email)
        VStack {
          SecureField(NSLocalizedString("password", comment: ""), text: $password)
            .textInputAutocapitalization(.never)
          Divider()
          SecureField(NSLocalizedString("confirmPassword", comment: ""), text: $passwordConfirmation)
            .textInputAutocapitalization(.never)
            border(Color.red, width: passwordConfirmation != password ? 1 : 0)
        }
        .padding()
        .background(.thinMaterial)
        .cornerRadius(10)
      }
    }
  }
}

struct SignUpCredentials_Previews: PreviewProvider {
  static var previews: some View {
    RegisterCredentials(email: .constant(""), password: .constant(""),
                        passwordConfirmation: .constant(""))
  }
}
