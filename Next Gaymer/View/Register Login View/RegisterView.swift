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
        PhotoPickerView(changeProfileImage: $registerModel.changeProfileImage,
                        openCameraRool: $registerModel.openCameraRool,
                        imageSelected: $registerModel.profilImage)
          .frame(maxWidth: .infinity, alignment: .center)
          .listRowBackground(Color(UIColor.systemGroupedBackground))
        Section {
          TextField(NSLocalizedString("firstName", comment: ""),
                    text: $registerModel.name)
          TextField(NSLocalizedString("lastName", comment: ""),
                    text: $registerModel.surname)
          TextField(NSLocalizedString("phone", comment: ""),
                    text: $registerModel.phoneNumber)
            .keyboardType(.phonePad)
          TextField("Email",
                    text: $registerModel.email)
            .textInputAutocapitalization(.never)
            .keyboardType(.emailAddress)
        } header: {
          Text("Contact")
        }
        Section {
          TextField("Pseudo",
                    text: $registerModel.pseudo)
          TextField("#0000Discord",
                    text: $registerModel.discordPseudo)
        } header: {
          Text(NSLocalizedString("network", comment: ""))
        }
        Section {
          TextField(NSLocalizedString("adress", comment: ""),
                    text: $registerModel.street)
          TextField(NSLocalizedString("zipCode", comment: ""),
                    text: $registerModel.zipCode)
            .keyboardType(.numberPad)
          TextField(NSLocalizedString("town", comment: ""),
                    text: $registerModel.city)
        } header: {
          Text(NSLocalizedString("adress", comment: ""))
        }
        Section {
          SecureField(NSLocalizedString("password", comment: ""),
                      text: $registerModel.password)
          SecureField(NSLocalizedString("confirm", comment: ""),
                      text: $registerModel.confirmPassword)
            .border(Color.red,
                    width: registerModel.confirmPassword != registerModel.password ? 1 : 0)
        } header: {
          Text(NSLocalizedString("password", comment: ""))
        }
        Button {
          registerModel.registerUser()
        } label: {
          Text(NSLocalizedString("createAccount", comment: ""))
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
        // .disabled(registerModel.disableButton())
      }
      .onReceive(registerModel.$requestStatus) { newValue in
        if registerModel.requestStatus == .success {
          viewRouter.currentPage = .loggedIn
        }
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
