//
//  UserAdminSwitcherView.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 22/01/2022.
//

import SwiftUI

struct UserAdminSwitcherView: View {
  
  @StateObject var currentUserModel = CurrentUserViewModel()
  @EnvironmentObject var tabBarRouter: TabBarRouter
  @EnvironmentObject var viewRouter: ViewRouter
  
    var body: some View {
      
      switch currentUserModel.currentUser?.isAdmin {
        
      case true:
        AdminView()
          .environmentObject(currentUserModel)
      case false:
        UserView()
          .environmentObject(currentUserModel)
      default:
        LoginView()
      }
    }
}

struct UserAdminSwitcherView_Previews: PreviewProvider {
    static var previews: some View {
      UserAdminSwitcherView().environmentObject(CurrentUserViewModel())
    }
}
