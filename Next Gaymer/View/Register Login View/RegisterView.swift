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
      Form {
        PhotoPickerView(changeProfileImage: $registerModel.changeProfileImage, openCameraRool: $registerModel.openCameraRool, imageSelected: $registerModel.profilImage)
          .frame(maxWidth: .infinity, alignment: .center)
          .listRowBackground(Color(UIColor.systemGroupedBackground))
        Section {
          TextField("Prénom", text: $registerModel.name)
          TextField("Nom", text: $registerModel.surname)
          TextField("Téléphone", text: $registerModel.phoneNumber)
            .keyboardType(.phonePad)
          TextField("Email", text: $registerModel.email)
            .textInputAutocapitalization(.never)
            .keyboardType(.emailAddress)
        } header: {
          Text("Contact")
        }
        Section {
          TextField("Pseudo", text: $registerModel.pseudo)
          TextField("#0000Discord", text: $registerModel.discordPseudo)
        } header: {
          Text("Résaux")
        }
        Section {
          TextField("Adresse", text: $registerModel.street)
          TextField("Code Postal", text: $registerModel.zipCode)
            .keyboardType(.numberPad)
          TextField("Ville", text: $registerModel.city)
        } header: {
          Text("Adresse")
        }
        Section {
          SecureField("Mot de passe", text: $registerModel.password)
          SecureField("Confirmer", text: $registerModel.confirmPassword)
            .border(Color.red, width: registerModel.confirmPassword != registerModel.password ? 1 : 0)
        } header: {
          Text("Mot de passe")
        }
        Button {
          registerModel.registerUser()
        } label: {
          Text("Valider l'inscription")
            .font(.title3)
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
            .padding()
            .frame(width: 200, height: 46)
            .background(Color.blue)
            .cornerRadius(15.0)
          
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .listRowBackground(Color(UIColor.systemGroupedBackground))
        .disabled(registerModel.disableButton())
      }
      .onReceive(registerModel.$requestStatus) { newValue in
            viewRouter.currentPage = .loggedIn
      }
      .alert(registerModel.errorMessage, isPresented: $registerModel.showAlert) {}
    }
  }
}

struct RegisterView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      RegisterView().environmentObject(ViewRouter())
    }
  }
}
