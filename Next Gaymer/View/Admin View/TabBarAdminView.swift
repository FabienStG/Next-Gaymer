//
//  AdminView.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 22/01/2022.
//

import SwiftUI

struct TabBarAdminView: View {

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

          EventListAdminView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black.opacity(0.04).ignoresSafeArea())
            .tag(Tab.home)
          MainMessageAdminView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black.opacity(0.04).ignoresSafeArea())
            .tag(Tab.message)
          HelpPageView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black.opacity(0.04).ignoresSafeArea())
            .tag(Tab.map)
          UsersListAdminView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black.opacity(0.04).ignoresSafeArea())
            .tag(Tab.profile)
        }

        CustomTabBar(animation: animation, size: size, bottomEdge: bottomEdge)
          .background(Color.white)
      }
    }
    .ignoresSafeArea(.all, edges: .bottom)
  }
}

struct TabBarAdminView_Previews: PreviewProvider {
    static var previews: some View {
      TabBarAdminView().environmentObject(TabBarRouter()).environmentObject(CurrentUserViewModel())
    }
}
