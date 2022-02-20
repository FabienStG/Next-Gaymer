//
//  UserDetailsAdminView.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 22/01/2022.
//

import SwiftUI

struct UserDetailsAdminView: View {
  
  @StateObject var userDetails: UserDetailsAdminViewModel
  
  var body: some View {
    VStack {
      UserLimitedView(userDetails: userDetails.selectedUser)
      NavigationLink {
        withAnimation {
          ChatLogView(
            selectedUser: SelectedUserViewModel(
              selectedUser: userDetails.selectedUser))
        }
      } label: {
        ButtonTextView(status: $userDetails.requestStatus,
                       text: NSLocalizedString("sendMessage", comment: ""))
      }
      .navigationTitle(NSLocalizedString("profile", comment: ""))
      .navigationBarTitleDisplayMode(.inline)
      if !userDetails.selectedUser.isAdmin {
        Divider()
        Button {
          userDetails.presentConfirmation.toggle()
        } label: {
          Text(NSLocalizedString("giveAdmin", comment: ""))
            .foregroundColor(.red)
        }
        .padding()
      }
    }
    .alert(userDetails.confirmationMessage,
           isPresented: $userDetails.presentAlert) {}
    .confirmationDialog(NSLocalizedString("confirm", comment: "") + " ?",
                        isPresented: $userDetails.presentConfirmation) {
      Button(role: .cancel) {} label: {
        Text(NSLocalizedString("cancel", comment: ""))
      }
      Button(role: .destructive) {
        userDetails.setUserAdminCrentials()
      } label: {
        Text(NSLocalizedString("validateAdmin", comment: ""))
      }
    }
  }
}

struct UserDetailsAdminView_Previews: PreviewProvider {
    static var previews: some View {
      UserDetailsAdminView(userDetails: UserDetailsAdminViewModel(
        selectedUser: FakePreviewData.fakeSelectedUser))
    }
}
