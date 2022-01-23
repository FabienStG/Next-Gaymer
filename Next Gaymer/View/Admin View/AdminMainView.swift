//
//  AdminView.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 22/01/2022.
//

import SwiftUI

struct AdminMainView: View {

  @Namespace var animation
  @EnvironmentObject var tabBarRouter: TabBarRouter
  @EnvironmentObject var viewRouter: ViewRouter
  @EnvironmentObject var currentUser: CurrentUserViewModel

  var body: some View {

    GeometryReader { proxy in

      let size = proxy.size
      let bottomEdge = proxy.safeAreaInsets.bottom

      ZStack(alignment: .bottom) {
        TabView(selection: $tabBarRouter.currentTab) {

          UserProfileView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black.opacity(0.04).ignoresSafeArea())
            .tag(Tab.home)
          UsersListAdminView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black.opacity(0.04).ignoresSafeArea())
            .tag(Tab.search)
          Text("Liked")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black.opacity(0.04).ignoresSafeArea())
            .tag(Tab.liked)
          Text("Settings")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black.opacity(0.04).ignoresSafeArea())
            .tag(Tab.settings)
        }

        CustomTabBar(animation: animation, size: size, bottomEdge: bottomEdge)
          .background(Color.white)
      }
    }
    .ignoresSafeArea(.all, edges: .bottom)
  }
}

struct AdminMainView_Previews: PreviewProvider {
    static var previews: some View {
      AdminMainView().environmentObject(TabBarRouter()).environmentObject(CurrentUserViewModel())
    }
}
