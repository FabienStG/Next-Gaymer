//
//  TabBarUserView.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 24/01/2022.
//

import SwiftUI

struct TabBarUserView: View {
  
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
            
            EventListView()
              .frame(maxWidth: .infinity, maxHeight: .infinity)
              .background(Color.black.opacity(0.04).ignoresSafeArea())
              .tag(Tab.event)
            MainMessageView()
              .frame(maxWidth: .infinity, maxHeight: .infinity)
              .background(Color.black.opacity(0.04).ignoresSafeArea())
              .tag(Tab.message)
            HelpPageView()
              .frame(maxWidth: .infinity, maxHeight: .infinity)
              .background(Color.black.opacity(0.04).ignoresSafeArea())
              .tag(Tab.help)
            ProfileView()
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

struct TabBarUserView_Previews: PreviewProvider {
    static var previews: some View {
      TabBarUserView().environmentObject(TabBarRouter())
        .environmentObject(FakePreviewData.currentUser)
    }
}
