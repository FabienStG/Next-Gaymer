//
//  GoogleRegisterView.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 10/02/2022.
//

import SwiftUI

struct GoogleRegisterView: View {
  
  @StateObject var googleRegisterModel = GoogleRegisterViewModel()
  @EnvironmentObject var viewRouter: ViewRouter
  
  @Environment(\.presentationMode) var presentationMode
  
    var body: some View {
      VStack {
        Form {
          Section {
            TextField(NSLocalizedString("firstName", comment: ""),
                      text: $googleRegisterModel.name)
              .disableAutocorrection(true)
            TextField(NSLocalizedString("lastName", comment: ""),
                      text: $googleRegisterModel.surname)
              .disableAutocorrection(true)
            TextField(NSLocalizedString("phone", comment: ""),
                      text: $googleRegisterModel.phoneNumber)
              .keyboardType(.phonePad)
          } header: {
            Text("Contact")
          }
          Section {
            TextField("Pseudo",
                      text: $googleRegisterModel.pseudo)
              .disableAutocorrection(true)
            TextField("Discord#0000",
                      text: $googleRegisterModel.discordPseudo)
              .disableAutocorrection(true)
          } header: {
            Text(NSLocalizedString("network", comment: ""))
          }
          Section {
            TextField(NSLocalizedString("adress", comment: ""),
                      text: $googleRegisterModel.street)
            TextField(NSLocalizedString("zipCode", comment: ""),
                      text: $googleRegisterModel.zipCode)
              .keyboardType(.numberPad)
            TextField(NSLocalizedString("town", comment: ""),
                      text: $googleRegisterModel.city)
          } header: {
            Text(NSLocalizedString("adress", comment: ""))
          }
          Button {
            googleRegisterModel.registerUserButton()
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
          .disabled(googleRegisterModel.disableButton())
          .frame(maxWidth: .infinity, alignment: .center)
          .listRowBackground(Color(UIColor.systemGroupedBackground))
        }
        .onReceive(googleRegisterModel.$requestStatus) { newValue in
          if newValue == .success {
            presentationMode.wrappedValue.dismiss()
          }
        }
        .alert(googleRegisterModel.errorMessage, isPresented: $googleRegisterModel.showAlert) {}
      }
    }
}

struct GoogleRegisterView_Previews: PreviewProvider {
    static var previews: some View {
      GoogleRegisterView().environmentObject(ViewRouter())
    }
}
