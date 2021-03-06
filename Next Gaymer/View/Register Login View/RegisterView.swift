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
            .disableAutocorrection(true)
          TextField(NSLocalizedString("lastName", comment: ""),
                    text: $registerModel.surname)
            .disableAutocorrection(true)
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
            .disableAutocorrection(true)
          TextField("Discord#0000",
                    text: $registerModel.discordPseudo)
            .disableAutocorrection(true)
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
          registerModel.registerUserButton()
        } label: {
          ButtonTextView(status: $registerModel.requestStatus, text: NSLocalizedString("createAccount", comment: ""))
          
        }
        .disabled(!registerModel.disableButton())
        .frame(maxWidth: .infinity, alignment: .center)
        .listRowBackground(Color(UIColor.systemGroupedBackground))
      }
      .onReceive(registerModel.$requestStatus) { newValue in
        if newValue == .success {
          withAnimation {
            viewRouter.currentPage = .loggedIn
          }
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
