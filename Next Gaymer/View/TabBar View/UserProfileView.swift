//
//  UserProfilView.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 17/01/2022.
//

import SwiftUI

struct UserProfileView: View {

  @StateObject var logoutModel = LogoutViewModel()
  @EnvironmentObject var viewRouter: ViewRouter

  let firebase = FirebaseUserService()

  var body: some View {

    VStack {
      Text("HomeView")
        .navigationTitle("Next Gaymer")
      Button {
        //
      } label: {
        Text("Afficher profil")
      }
      Button("Se déconnecter") {
        logoutModel.logoutUser()
        if logoutModel.requestStatus == .success {
          withAnimation {
            viewRouter.currentPage = .loggedOut
          }
        }
      }
    }
    .alert(logoutModel.errorMessage, isPresented: $logoutModel.showAlert) {}
  }
}


struct UserProfileView_Previews: PreviewProvider {
  static var previews: some View {
    UserProfileView()
  }
}
