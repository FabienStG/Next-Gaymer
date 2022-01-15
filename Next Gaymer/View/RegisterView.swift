//
//  test.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 15/01/2022.
//

import SwiftUI

struct RegisterView: View {
    
    @StateObject var registerModel = RegisterViewModel()
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        
        VStack {
            LogoView()
            Text("Creer ton compte")
                .font(.title)
            Form {
                Section {
                    TextField("Nom", text: $registerModel.name)
                    TextField("Prénom", text: $registerModel.surname)
                    TextField("Téléphone", text: $registerModel.phoneNumber)
                    TextField("Email", text: $registerModel.email)
                    
                } header: {
                    Text("Contact")
                }
                Section {
                    TextField("Adresse", text: $registerModel.street)
                    TextField("Code Postal", text: $registerModel.zipCode)
                    TextField("Pays", text: $registerModel.city)
                } header: {
                    Text("Adresse")
                }
                Section {
                    SecureField("Mot de passe", text: $registerModel.password)
                    SecureField("Confirmer", text: $registerModel.confirmPassword)
                } header: {
                    Text("Mot de passe")
                }
            }
            Button {
                registerModel.registerUser { result in
                    if result {
                        withAnimation {
                            viewRouter.currentPage = .loggedIn
                        }
                    }
                }
            } label: {
                Text("S'enregistrer")
                    .frame(height: 50, alignment: .center)
            }
            .disabled(registerModel.disableButton())
            .alert(registerModel.errorMessage, isPresented: $registerModel.showAlert) {}
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
