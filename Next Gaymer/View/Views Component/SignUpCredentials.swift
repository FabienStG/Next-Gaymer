//
//  SignUpCredentials.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 13/01/2022.
//

import SwiftUI

struct SignUpCredentials: View {
    
    @Binding var email: String
    @Binding var password: String
    @Binding var passwordConfirmation: String
    
    var body: some View {
        VStack {
            Group{
                TextField("Email", text:$email)
                    .padding()
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
                    .disableAutocorrection(true)
                    .background(.thinMaterial)
                    .cornerRadius(10)
                VStack {
                    SecureField("Mot de passe", text: $password)
                    .textInputAutocapitalization(.never)
                Divider()
                SecureField("Confirmer mot de passe", text: $passwordConfirmation)
                    .textInputAutocapitalization(.never)
                    .border(Color.red, width: passwordConfirmation != password ? 1 : 0)
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
        SignUpCredentials(email: .constant(""), password: .constant(""), passwordConfirmation: .constant(""))//.previewLayout(.sizeThatFits)
    }
}
