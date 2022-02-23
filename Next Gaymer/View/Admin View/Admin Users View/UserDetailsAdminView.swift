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
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          if !userDetails.selectedUser.isAdmin {
            Button {
              userDetails.presentOption.toggle()
            } label: {
              Image(systemName: "ellipsis.circle.fill")
            }
          }
        }
      }
    }
    .alert(userDetails.confirmationMessage,
           isPresented: $userDetails.presentAlert) {}
     .confirmationDialog("confirmation",
                         isPresented: $userDetails.presentConfirmation) {
       Button(role: .destructive) {
         userDetails.setUserAdminCrentials()
       } label: {
         Text(NSLocalizedString("validateAdmin", comment: ""))
       }
     }
   .confirmationDialog("options", isPresented: $userDetails.presentOption) {
     Button {
       userDetails.presentConfirmation.toggle()
     } label : {
       Text(NSLocalizedString("giveAdmin", comment: ""))
         .foregroundColor(.red)
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
