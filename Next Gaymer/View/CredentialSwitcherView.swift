//
//  UserAdminSwitcherView.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 22/01/2022.
//

import SwiftUI

struct CredentialSwitcherView: View {
  
  @StateObject var currentUserModel = CurrentUserViewModel()
  @EnvironmentObject var tabBarRouter: TabBarRouter
  @EnvironmentObject var viewRouter: ViewRouter
  
    var body: some View {

      switch currentUserModel.currentUser?.isAdmin {
        
      case true:
        TabBarAdminView()
          .environmentObject(currentUserModel)
      case false:
        TabBarUserView()
          .environmentObject(currentUserModel)
      default:
        LoginView()
          .alert(currentUserModel.errorMessage, isPresented: $currentUserModel.showAlert) {}
      }
    }
}

struct UserAdminSwitcherView_Previews: PreviewProvider {
    static var previews: some View {
      CredentialSwitcherView().environmentObject(CurrentUserViewModel())
    }
}
