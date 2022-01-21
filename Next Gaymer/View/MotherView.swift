//
//  MotherView.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 14/01/2022.
//

import SwiftUI

struct MotherView: View {

  @EnvironmentObject var viewRouter: ViewRouter
  @EnvironmentObject var tabBarRouter: TabBarRouter

  var body: some View {

    switch viewRouter.currentPage {
    case .loggedOut:
      LoginView()
    case .loggedIn:
      HomepageView()
    }
  }
}


struct MotherView_Previews: PreviewProvider {
  static var previews: some View {
    MotherView().environmentObject(ViewRouter()).environmentObject(TabBarRouter())
  }
}
