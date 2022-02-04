//
//  UserProfilView.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 17/01/2022.
//

import SwiftUI

struct ProfileView: View {

  @StateObject var logoutModel = LogoutViewModel()
  @EnvironmentObject var viewRouter: ViewRouter
  @EnvironmentObject var currentUser: CurrentUserViewModel

  let firebase = FirebaseUserService()

  var body: some View {
    VStack {
      UserView(currentUser: currentUser.currentUser!)
      Button {
        logoutModel.logoutUser()
        if logoutModel.requestStatus == .success {
          withAnimation {
            viewRouter.currentPage = .loggedOut
          }
        }
      } label: {
        ButtonTextView(status: $logoutModel.requestStatus,
                       text: NSLocalizedString("logout", comment: ""))
      }
    }
    .alert(logoutModel.errorMessage, isPresented: $logoutModel.showAlert) {}
  }
}


struct SeflDetailsView_Previews: PreviewProvider {
  static var previews: some View {
    ProfileView().environmentObject(FakePreviewData.currentAdminUser)
  }
}
