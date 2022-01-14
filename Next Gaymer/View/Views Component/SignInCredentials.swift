//
//  SignInCredentials.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 13/01/2022.
//

import SwiftUI

struct SignInCredentials: View {
    
    @Binding var email: String
    @Binding var password: String
    
    var body: some View {
        VStack {
            Group {
                TextField("Email", text: $email)
                    .padding()
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
                    .disableAutocorrection(true)
                    .background(.thinMaterial)
                    .cornerRadius(10)
                SecureField("Mot de passe", text: $password)
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
        SignInCredentials(email: .constant(""), password: .constant(""))
    }
}
