//
//  ViewRouter.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 13/01/2022.
//

import SwiftUI

class ViewRouter: ObservableObject {

  init() {
    if DataManager.shared.logStatus {
      currentPage = .loggedIn
    } else {
      currentPage = .loggedOut
    }
  }

  @Published var currentPage: Page

}

enum Page {

  case loggedOut
  case loggedIn
}
