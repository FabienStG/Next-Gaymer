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
        AdminMainView()
          .environmentObject(currentUserModel)
      case false:
        UserMainView()
          .environmentObject(currentUserModel)
      default:
        LoginView()
      }
    }
}

struct UserAdminSwitcherView_Previews: PreviewProvider {
    static var previews: some View {
      CredentialSwitcherView().environmentObject(CurrentUserViewModel())
    }
}
