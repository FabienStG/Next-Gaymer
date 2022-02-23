//
//  UserProfilView.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 17/01/2022.
//

import SwiftUI

struct ProfileView: View {
  
  @StateObject var profileModel = ProfileViewModel()
  
  @EnvironmentObject var viewRouter: ViewRouter
  @EnvironmentObject var currentUser: CurrentUserViewModel
  
  var body: some View {
    VStack {
      Form {
        ProfilePictureView(url: currentUser.currentUser!.profileImageUrl)
          .padding()
          .frame(maxWidth: .infinity, alignment: .center)
          .listRowBackground(Color(UIColor.systemGroupedBackground))
        Section {
          TextField(NSLocalizedString(currentUser.currentUser!.name, comment: ""),
                    text: $profileModel.name)
            .disabled(profileModel.disableModification)
            .disableAutocorrection(true)
          TextField(NSLocalizedString(currentUser.currentUser!.surname, comment: ""),
                    text: $profileModel.surname)
            .disabled(profileModel.disableModification)
            .disableAutocorrection(true)
          TextField(NSLocalizedString(currentUser.currentUser!.phoneNumber, comment: ""),
                    text: $profileModel.phoneNumber)
            .disabled(profileModel.disableModification)
            .keyboardType(.phonePad)
        } header: {
          Text("Contact")
        }
        Section {
          TextField(currentUser.currentUser!.pseudo,
                    text: $profileModel.pseudo)
            .disabled(profileModel.disableModification)
            .disableAutocorrection(true)
          TextField(currentUser.currentUser!.discordPseudo,
                    text: $profileModel.discordPseudo)
            .disabled(profileModel.disableModification)
            .disableAutocorrection(true)
        } header: {
          Text(NSLocalizedString("network", comment: ""))
        }
        Section {
          TextField(NSLocalizedString(currentUser.currentUser!.street, comment: ""),
                    text: $profileModel.street)
            .disabled(profileModel.disableModification)
          TextField(NSLocalizedString(currentUser.currentUser!.zipCode, comment: ""),
                    text: $profileModel.zipCode)
            .disabled(profileModel.disableModification)
            .keyboardType(.numberPad)
          TextField(NSLocalizedString(currentUser.currentUser!.city, comment: ""),
                    text: $profileModel.city)
            .disabled(profileModel.disableModification)
        } header: {
          Text(NSLocalizedString("adress", comment: ""))
            .disabled(profileModel.disableModification)
        }
        if !profileModel.disableModification {
          Button {
            profileModel.validateModifications()
            
          } label: {
            ButtonTextView(status: $profileModel.requestStatus,
                           text: NSLocalizedString("confirm", comment: ""))
          }
          .frame(maxWidth: .infinity, alignment: .center)
          .listRowBackground(Color(UIColor.systemGroupedBackground))
        }
      }
      .toolbar {
        ToolbarItem(placement: .primaryAction) {
          Button {
            profileModel.showConfirmation.toggle()
          } label: {
            Image(systemName: "gearshape.fill")
          }
        }
      }
      .alert(profileModel.errorMessage, isPresented: $profileModel.showAlert) {}
      .sheet(isPresented: $profileModel.showReauthentification) {
        ConfirmationDeleteView()
      }
      .confirmationDialog("Options", isPresented: $profileModel.showConfirmation) {
        Button {
          profileModel.logoutUser()
        } label: {
          Text(NSLocalizedString("logout", comment: ""))
        }
        Button {
          profileModel.modifyProfile(user: currentUser.currentUser!)
        } label: {
          Text(NSLocalizedString("changeProfile", comment: ""))
        }
        Button(role: .destructive) {
          profileModel.showReauthentification.toggle()
        } label: {
          Text(NSLocalizedString("deleteAccount", comment: ""))
        }
      }
    }
    .onReceive(profileModel.$requestStatus) { newValue in
      if newValue == .success {
        withAnimation {
          viewRouter.currentPage = .loggedOut
        }
      }
    }
    .onReceive(profileModel.$updateComplete) { newValue in
      if newValue {
        currentUser.fetchCurrentUser()
      }
    }
  }
}

struct SeflDetailsView_Previews: PreviewProvider {
  static var previews: some View {
    ProfileView()
      .environmentObject(FakePreviewData.currentAdminUser)
  }
}
