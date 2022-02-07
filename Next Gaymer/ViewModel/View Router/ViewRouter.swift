//
//  ViewRouter.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 13/01/2022.
//

import SwiftUI
//
// MARK: - View Router
//

/// This class check is the user is already login and manage the page
class ViewRouter: ObservableObject {
  //
  // MARK: - Published Propertie
  //
  @Published var currentPage: Page
  
  //
  // MARK: - Initialization
  //
  init() {
    if DataManager.shared.logStatus {
      currentPage = .loggedIn
    } else {
      currentPage = .loggedOut
    }
  }
}

//
// MARK: - Page Enum
//
enum Page {

  case loggedOut
  case loggedIn
}
